package com.sample_pro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * 출퇴근 PLC 자동 저장 스케줄러
 *
 * 2초마다 실행하여 PLC D45/D46/D61~D64 값을 읽고
 * 저장 조건 충족 시 tb_ez_in_out_list_page 에 insert 한다.
 *
 * 주의:
 *  - D46 리셋은 PLC가 수행하므로 자바에서 write 금지
 *  - 중복 저장 방지는 EzInOutAttendServiceImpl 내에서 처리
 */
@Component
public class EzInOutScheduler {

    @Autowired
    private EzInOutAttendService attendService;

    /**
     * fixedDelay = 2000ms → 이전 실행 완료 후 2초 대기 후 재실행
     * (PLC 응답 지연 발생 시 중첩 실행 방지)
     */
    @Scheduled(fixedDelay = 2000)
    public void checkAttendance() {
        try {
            attendService.checkAndSave();
        } catch (Exception e) {
            System.err.println(">>> [EzInOutScheduler] 예외 발생: " + e.getMessage());
        }
    }
}
