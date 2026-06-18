package com.sample_pro.service.management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class EzInOutScheduler {

    @Autowired
    private EzInOutAttendService ezInOutAttendService;

    @Scheduled(fixedDelay = 1000)
    public void pollPlc() {
        try {
            ezInOutAttendService.checkAndSave();
        } catch (Exception e) {
            // PLC 미연결 등 — 다음 주기에 재시도
        }
    }
}
