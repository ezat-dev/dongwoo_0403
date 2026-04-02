package com.sample_pro.dao;

import java.util.List;

import com.sample_pro.domain.CompanyEmployee;
import com.sample_pro.domain.EzInOutVisit;

public interface EzInOutDao {
    void ensureVisitTable();
    void ensureVisitReasonColumns();
    void ensurePinTable();
    List<CompanyEmployee> selectCompanyEmployeeList();
    void insertVisit(EzInOutVisit visit);
    EzInOutVisit getVisitById(long visitId);
    int countMatchingPin(String pin);
    int countMatchingPwNo(String pwNo);
    CompanyEmployee selectEmployeeByPwNo(String pwNo);
}
