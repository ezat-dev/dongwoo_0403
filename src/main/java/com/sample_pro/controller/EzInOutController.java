package com.sample_pro.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.sample_pro.domain.CompanyEmployee;
import com.sample_pro.domain.EzInOutVisit;
import com.sample_pro.domain.SolapiSendResult;
import com.sample_pro.service.EzInOutService;
import com.sample_pro.service.SolapiKakaoService;

@Controller
@RequestMapping("/ez_in_out")
public class EzInOutController {

    private static final Pattern PHONE_PATTERN = Pattern.compile("^0\\d{1,2}-\\d{3,4}-\\d{4}$");

    // PIN 잠금 관련 상수
    private static final int  PIN_MAX_ATTEMPTS = 5;
    private static final long PIN_LOCK_MILLIS  = 5 * 60 * 1000L;

    // PLC C# API 주소
    private static final String CSHARP_API            = "http://localhost:5050";

    // PIN 성공 → D13000 = 1
    private static final int    PLC_DOOR_PIN_ADDRESS  = 13000;
    private static final int    PLC_DOOR_PIN_VALUE    = 1;

    // 카톡 문열기 버튼 → D13001 = 1
    private static final int    PLC_DOOR_TAKE_ADDRESS = 13001;
    private static final int    PLC_DOOR_TAKE_VALUE   = 1;

    // 세션 키
    private static final String SESSION_PIN_ATTEMPTS     = "ez_pin_attempts";
    private static final String SESSION_PIN_LOCKED_UNTIL = "ez_pin_locked_until";
    private static final String SESSION_EMP_AUTH         = "ez_emp_authenticated";

    @Autowired
    private EzInOutService ezInOutService;

    @Autowired
    private SolapiKakaoService solapiKakaoService;

    private final RestTemplate rest = new RestTemplate();

    /* =============================================
       방문록 메인 페이지
    ============================================= */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String mainPage() {
        return "/ez_in_out/ez_in_out_main.jsp";
    }

    /* =============================================
       PIN 인증 페이지 (GET)
    ============================================= */
    @RequestMapping(value = "/pin", method = RequestMethod.GET)
    public String pinPage() {
        return "/ez_in_out/ez_pin.jsp";
    }

    /* =============================================
       카카오 알림톡 수신 페이지 (GET)
       URL: /ez_in_out/take?id={visitId}
    ============================================= */
    @RequestMapping(value = "/take", method = RequestMethod.GET)
    public String takePage() {
        return "/ez_in_out/take.jsp";
    }

    /* =============================================
       방문 정보 조회 API (카카오 take 페이지용)
       GET /ez_in_out/take/info?id={visitId}
    ============================================= */
    @RequestMapping(
        value    = "/take/info",
        method   = RequestMethod.GET,
        produces = MediaType.APPLICATION_JSON_VALUE
    )
    @ResponseBody
    public ResponseEntity<?> takeInfo(
            @RequestParam(value = "id", defaultValue = "") String id) {

        if (id.isEmpty()) {
            return ResponseEntity.ok(error("방문 ID가 없습니다."));
        }

        long visitId;
        try {
            visitId = Long.parseLong(id);
        } catch (NumberFormatException e) {
            return ResponseEntity.ok(error("유효하지 않은 방문 ID입니다."));
        }

        try {
            EzInOutVisit visit = ezInOutService.getVisitById(visitId);
            if (visit == null) {
                return ResponseEntity.ok(error("방문 정보를 찾을 수 없습니다."));
            }

            Map<String, Object> response = new LinkedHashMap<>();
            response.put("success", true);
            response.put("data", visit);
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.ok(error("방문 정보 조회 실패: " + detailMessage(e)));
        }
    }

    /* =============================================
       카톡 문열기 버튼 API
       POST /ez_in_out/take/open-door
       Body: { "visitId": "123" }
       → PLC D13001 <- 1
    ============================================= */
    @RequestMapping(
        value    = "/take/open-door",
        method   = RequestMethod.POST,
        produces = MediaType.APPLICATION_JSON_VALUE
    )
    @ResponseBody
    public ResponseEntity<?> takeOpenDoor(@RequestBody Map<String, Object> body) {
        String visitIdStr = trim(body.get("visitId"));
        System.out.println(">>> [TAKE OPEN] visitId=" + visitIdStr);

        // D13001 <- 1
        String plcResult = writePlc(PLC_DOOR_TAKE_ADDRESS, PLC_DOOR_TAKE_VALUE);
        boolean plcOk    = !plcResult.startsWith("plc_error");

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("success", plcOk);
        response.put("plc", plcResult);

        if (!plcOk) {
            response.put("error", "PLC 통신 오류가 발생했습니다.");
        }

        System.out.println(">>> [TAKE OPEN] D" + PLC_DOOR_TAKE_ADDRESS + "=" + PLC_DOOR_TAKE_VALUE + " → " + plcResult);
        return ResponseEntity.ok(response);
    }

    /* =============================================
       직원 대시보드 (PIN 인증 후 이동)
    ============================================= */
    @RequestMapping(value = "/employee/dashboard", method = RequestMethod.GET)
    public String employeeDashboard(HttpSession session) {
        Boolean auth = (Boolean) session.getAttribute(SESSION_EMP_AUTH);
        if (auth == null || !auth) {
            return "redirect:/ez_in_out/pin";
        }
        return "/ez_in_out/ez_employee_dashboard.jsp";
    }

    /* =============================================
       PIN 인증 API
       성공 시 PLC D13000 <- 1
    ============================================= */
    @RequestMapping(
        value    = "/employee/verify-pin",
        method   = RequestMethod.POST,
        produces = MediaType.APPLICATION_JSON_VALUE
    )
    @ResponseBody
    public ResponseEntity<?> verifyPin(
            @RequestBody Map<String, Object> body,
            HttpSession session) {

        Long lockedUntil = (Long) session.getAttribute(SESSION_PIN_LOCKED_UNTIL);
        if (lockedUntil != null && System.currentTimeMillis() < lockedUntil) {
            long remainSec = (lockedUntil - System.currentTimeMillis()) / 1000;
            return ResponseEntity.ok(error("잠금 상태입니다. " + remainSec + "초 후 다시 시도해 주세요."));
        }

        String pin = trim(body.get("pin"));
        if (pin.isEmpty())          return ResponseEntity.ok(error("PIN을 입력해 주세요."));
        if (!pin.matches("\\d{6}")) return ResponseEntity.ok(error("PIN은 숫자 6자리입니다."));

        boolean correct;
        try {
            correct = ezInOutService.verifyEmployeePwNo(pin);
        } catch (Exception e) {
            return ResponseEntity.ok(error("PIN 검증 오류: " + detailMessage(e)));
        }

        if (correct) {
            session.removeAttribute(SESSION_PIN_ATTEMPTS);
            session.removeAttribute(SESSION_PIN_LOCKED_UNTIL);
            session.setAttribute(SESSION_EMP_AUTH, Boolean.TRUE);

            // 직원 정보 조회
            CompanyEmployee emp = null;
            try {
                emp = ezInOutService.getEmployeeByPwNo(pin);
            } catch (Exception e) {
                System.out.println(">>> [PIN OK] 직원 정보 조회 오류: " + e.getMessage());
            }

            // 입장 기록 저장 (PIN으로 입장한 경우)
            if (emp != null) {
                try {
                    java.time.LocalDateTime now = java.time.LocalDateTime.now();
                    java.time.format.DateTimeFormatter fmt = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                    String visitTime = now.format(fmt);

                    EzInOutVisit visit = new EzInOutVisit();
                    visit.setVisitTime(visitTime);
                    visit.setVisitorName(emp.getEmpName());
                    visit.setVisitorPhone(emp.getMobileNo() != null ? emp.getMobileNo() : "");
                    visit.setTargetEmpId(emp.getEmpId() != null ? emp.getEmpId().toString() : "");
                    visit.setTargetDeptName(emp.getDeptName());
                    visit.setTargetEmpName(emp.getEmpName());
                    visit.setTargetTitleName(emp.getTitleName());
                    visit.setTargetMobileNo(emp.getMobileNo());
                    visit.setTargetDirectNo(emp.getDirectNo());
                    visit.setVisitReason("PIN_IN");
                    visit.setVisitReasonEtc("");
                    visit.setAgreeYn("Y");

                    ezInOutService.saveVisit(visit);
                    System.out.println(">>> [PIN OK] 입장 기록 저장 완료: visitId=" + visit.getVisitId());
                } catch (Exception e) {
                    System.out.println(">>> [PIN OK] 입장 기록 저장 오류: " + detailMessage(e));
                }
            }

            // D13000 <- 1
            String plcResult = writePlc(PLC_DOOR_PIN_ADDRESS, PLC_DOOR_PIN_VALUE);
            System.out.println(">>> [PIN OK] D" + PLC_DOOR_PIN_ADDRESS + "=1 → " + plcResult);

            Map<String, Object> response = new LinkedHashMap<>();
            response.put("success", true);
            response.put("plc", plcResult);
            return ResponseEntity.ok(response);

        } else {
            int attempts = getAttempts(session) + 1;
            session.setAttribute(SESSION_PIN_ATTEMPTS, attempts);

            if (attempts >= PIN_MAX_ATTEMPTS) {
                long lockUntil = System.currentTimeMillis() + PIN_LOCK_MILLIS;
                session.setAttribute(SESSION_PIN_LOCKED_UNTIL, lockUntil);
                session.setAttribute(SESSION_PIN_ATTEMPTS, 0);
                return ResponseEntity.ok(error("PIN 입력을 " + PIN_MAX_ATTEMPTS + "회 실패하여 5분간 잠겼습니다."));
            }

            return ResponseEntity.ok(error("PIN이 올바르지 않습니다. (" + (PIN_MAX_ATTEMPTS - attempts) + "회 남음)"));
        }
    }

    /* =============================================
       직원 목록 API
    ============================================= */
    @RequestMapping(
        value    = "/employee/list",
        method   = RequestMethod.GET,
        produces = MediaType.APPLICATION_JSON_VALUE
    )
    @ResponseBody
    public ResponseEntity<?> employeeList() {
        try {
            List<CompanyEmployee> employees = ezInOutService.getCompanyEmployeeList();
            Map<String, Object> response = new LinkedHashMap<>();
            response.put("success", true);
            response.put("data", employees);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.ok(error("직원 목록 조회 실패: " + detailMessage(e)));
        }
    }

    /* =============================================
       방문 저장 API
    ============================================= */
    @RequestMapping(
        value    = "/visit/save",
        method   = RequestMethod.POST,
        produces = MediaType.APPLICATION_JSON_VALUE
    )
    @ResponseBody
    public ResponseEntity<?> saveVisit(@RequestBody Map<String, Object> body) {
        String visitTime       = trim(body.get("visitTime"));
        String visitorName     = trim(body.get("visitorName"));
        String visitorPhone    = trim(body.get("visitorPhone"));
        String targetEmpId     = trim(body.get("targetEmpId"));
        String targetDeptName  = trim(body.get("targetDeptName"));
        String targetEmpName   = trim(body.get("targetEmpName"));
        String targetTitleName = trim(body.get("targetTitleName"));
        String targetMobileNo  = trim(body.get("targetMobileNo"));
        String targetDirectNo  = trim(body.get("targetDirectNo"));
        String visitReason     = normalizeVisitReason(trim(body.get("visitReason")));
        String visitReasonEtc  = trim(body.get("visitReasonEtc"));

        if (visitorName.isEmpty())
            return ResponseEntity.ok(error("이름을 입력해 주세요."));
        if (visitorPhone.isEmpty())
            return ResponseEntity.ok(error("전화번호를 입력해 주세요."));
        if (!PHONE_PATTERN.matcher(visitorPhone).matches())
            return ResponseEntity.ok(error("전화번호 형식이 올바르지 않습니다."));
        if (targetEmpId.isEmpty() || targetEmpName.isEmpty())
            return ResponseEntity.ok(error("호출할 직원을 선택해 주세요."));
        if (visitReason.isEmpty())
            return ResponseEntity.ok(error("방문 사유를 선택해 주세요."));
        if ("기타".equals(visitReason) && visitReasonEtc.isEmpty())
            return ResponseEntity.ok(error("기타 사유를 입력해 주세요."));
        if (visitTime.isEmpty())
            visitTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

        EzInOutVisit visit = new EzInOutVisit();
        visit.setVisitTime(visitTime);
        visit.setVisitorName(visitorName);
        visit.setVisitorPhone(visitorPhone);
        visit.setTargetEmpId(targetEmpId);
        visit.setTargetDeptName(targetDeptName);
        visit.setTargetEmpName(targetEmpName);
        visit.setTargetTitleName(targetTitleName);
        visit.setTargetMobileNo(targetMobileNo);
        visit.setTargetDirectNo(targetDirectNo);
        visit.setVisitReason(visitReason);
        visit.setVisitReasonEtc(visitReasonEtc);
        visit.setAgreeYn("Y");

        try {
            EzInOutVisit savedVisit = ezInOutService.saveVisit(visit);
            SolapiSendResult notification = solapiKakaoService.sendVisitNotification(savedVisit);

            Map<String, Object> response = new LinkedHashMap<>();
            response.put("success", true);
            response.put("data", savedVisit);
            response.put("notification", notification);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.ok(error("방문 정보 저장 실패: " + detailMessage(e)));
        }
    }

    /* =============================================
       공통: PLC 주소에 값 쓰기
       실패해도 예외를 던지지 않고 문자열로 반환
    ============================================= */
    private String writePlc(int address, int value) {
        try {
            Map<String, Integer> writeBody = new LinkedHashMap<>();
            writeBody.put("address", address);
            writeBody.put("value",   value);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Map<String, Integer>> entity = new HttpEntity<>(writeBody, headers);

            Map<?, ?> res = rest.exchange(
                CSHARP_API + "/api/plc/write",
                HttpMethod.POST,
                entity,
                Map.class
            ).getBody();

            return res != null ? res.toString() : "ok";

        } catch (Exception e) {
            System.out.println(">>> [PLC WRITE ERR] D" + address + " : " + e.getMessage());
            return "plc_error: " + e.getMessage();
        }
    }

    /* =============================================
       헬퍼 메서드
    ============================================= */
    private int getAttempts(HttpSession session) {
        Object val = session.getAttribute(SESSION_PIN_ATTEMPTS);
        return (val instanceof Integer) ? (Integer) val : 0;
    }

    private Map<String, Object> error(String message) {
        Map<String, Object> r = new LinkedHashMap<>();
        r.put("success", false);
        r.put("error", message);
        return r;
    }

    private String trim(Object value) {
        return value == null ? "" : String.valueOf(value).trim();
    }

    private String detailMessage(Throwable t) {
        while (t.getCause() != null) t = t.getCause();
        String m = t.getMessage();
        return (m == null || m.trim().isEmpty())
            ? t.getClass().getSimpleName()
            : t.getClass().getSimpleName() + ": " + m;
    }

    private String normalizeVisitReason(String r) {
        if ("simple_visit".equals(r)) return "단순 방문";
        if ("purchase".equals(r))     return "구매";
        if ("ex1".equals(r))          return "ex1";
        if ("ex4".equals(r))          return "ex4";
        if ("other".equals(r))        return "기타";
        return r;
    }
}