package com.sample_pro.service.management;

import com.sample_pro.domain.Corp;
import java.util.Map;

public interface CorpInsertService {
    Map<String, Object> getList(Map<String, Object> params);
    Corp getOne(String corpCode);
    void save(Corp corp);
    void delete(String corpCode);
}
