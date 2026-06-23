package com.sample_pro.service.management;

import com.sample_pro.domain.Tester;
import java.util.Map;

public interface TesterInsertService {
    Map<String, Object> getList(Map<String, Object> params);
    Tester getOne(String terCode);
    void save(Tester tester);
    void delete(String terCode);
}
