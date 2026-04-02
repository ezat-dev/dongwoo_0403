package com.sample_pro.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sample_pro.dao.EzInOutDao;
import com.sample_pro.domain.CompanyEmployee;
import com.sample_pro.domain.EzInOutVisit;

@Service
public class EzInOutServiceImpl implements EzInOutService {

    @Autowired
    private EzInOutDao ezInOutDao;

    private void ensureTables() {
        ezInOutDao.ensureVisitTable();
        ezInOutDao.ensureVisitReasonColumns();
    }

    @Override
    public List<CompanyEmployee> getCompanyEmployeeList() {
        return ezInOutDao.selectCompanyEmployeeList();
    }

    @Override
    @Transactional
    public EzInOutVisit saveVisit(EzInOutVisit visit) {
        ensureTables();
        ezInOutDao.insertVisit(visit);
        return visit;
    }

    @Override
    public EzInOutVisit getVisitById(long visitId) {
        return ezInOutDao.getVisitById(visitId);
    }

    @Override
    public boolean verifyEmployeePin(String pin) {
        ezInOutDao.ensurePinTable();
        return ezInOutDao.countMatchingPin(pin) > 0;
    }

    @Override
    public boolean verifyEmployeePwNo(String pwNo) {
        return ezInOutDao.countMatchingPwNo(pwNo) > 0;
    }

    @Override
    public CompanyEmployee getEmployeeByPwNo(String pwNo) {
        return ezInOutDao.selectEmployeeByPwNo(pwNo);
    }
}
