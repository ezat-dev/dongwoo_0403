package com.sample_pro.controller.management;

import com.sample_pro.domain.Tester;
import com.sample_pro.service.management.TesterInsertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/tester")
public class TesterInsertController {

    @Autowired
    private TesterInsertService testerInsertService;

    @RequestMapping(value = "/list", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> list(
            @RequestParam(defaultValue = "") String kwTerName,
            @RequestParam(defaultValue = "") String kwTerNo,
            @RequestParam(defaultValue = "") String kwTerKind,
            @RequestParam(defaultValue = "1")  int page,
            @RequestParam(defaultValue = "20") int pageSize) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("kwTerName", kwTerName.trim());
            params.put("kwTerNo",   kwTerNo.trim());
            params.put("kwTerKind", kwTerKind.trim());
            params.put("page",     page);
            params.put("pageSize", pageSize);
            return ResponseEntity.ok(testerInsertService.getList(params));
        } catch (Exception e) { return ResponseEntity.ok(err("조회 실패: " + e.getMessage())); }
    }

    @RequestMapping(value = "/detail", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> detail(@RequestParam String terCode) {
        try {
            Tester t = testerInsertService.getOne(terCode);
            if (t == null) return ResponseEntity.ok(err("측정기기를 찾을 수 없습니다."));
            return ResponseEntity.ok(t);
        } catch (Exception e) { return ResponseEntity.ok(err("조회 실패: " + e.getMessage())); }
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> save(@RequestBody Tester tester) {
        try {
            testerInsertService.save(tester);
            Map<String, Object> result = ok();
            result.put("terCode", tester.getTer_code());
            return ResponseEntity.ok(result);
        } catch (Exception e) { return ResponseEntity.ok(err("저장 실패: " + e.getMessage())); }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> delete(@RequestBody Map<String, Object> body) {
        try {
            testerInsertService.delete(body.get("terCode").toString());
            return ResponseEntity.ok(ok());
        } catch (Exception e) { return ResponseEntity.ok(err("삭제 실패: " + e.getMessage())); }
    }

    private Map<String, Object> ok()  { Map<String,Object> m=new HashMap<>(); m.put("success",true);  return m; }
    private Map<String, Object> err(String msg) { Map<String,Object> m=new HashMap<>(); m.put("success",false); m.put("error",msg); return m; }
}
