package com.sample_pro.service.management;

import com.sample_pro.domain.Fac;
import java.util.Map;

public interface FacInsertService {
    Map<String, Object> getList(Map<String, Object> params);
    Fac getOne(String facCode);
    void save(Fac fac);
    void delete(String facCode);
}
