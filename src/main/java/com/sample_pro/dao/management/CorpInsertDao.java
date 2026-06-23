package com.sample_pro.dao.management;

import com.sample_pro.domain.Corp;
import java.util.List;
import java.util.Map;

public interface CorpInsertDao {
    List<Corp> selectList(Map<String, Object> params);
    int selectCount(Map<String, Object> params);
    String selectMaxCode();
    Corp selectOne(String corpCode);
    void insert(Corp corp);
    void update(Corp corp);
    void delete(String corpCode);
}
