package com.sample_pro.service;

import java.util.List;

import com.sample_pro.domain.CompanyEmployee;
import com.sample_pro.domain.EzInOutVisit;

public interface EzInOutService {
    List<CompanyEmployee> getCompanyEmployeeList();
    EzInOutVisit saveVisit(EzInOutVisit visit);
    EzInOutVisit getVisitById(long visitId);
    boolean verifyEmployeePin(String pin);
    boolean verifyEmployeePwNo(String pwNo);
    CompanyEmployee getEmployeeByPwNo(String pwNo);
}
