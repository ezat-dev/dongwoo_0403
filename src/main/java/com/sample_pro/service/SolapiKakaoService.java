package com.sample_pro.service;

import com.sample_pro.domain.EzInOutVisit;
import com.sample_pro.domain.SolapiSendResult;

public interface SolapiKakaoService {
    SolapiSendResult sendVisitNotification(EzInOutVisit visit);
}
