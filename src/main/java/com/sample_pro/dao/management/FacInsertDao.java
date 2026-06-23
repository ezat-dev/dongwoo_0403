package com.sample_pro.dao.management;

import com.sample_pro.domain.Fac;
import java.util.List;
import java.util.Map;

public interface FacInsertDao {
    List<Fac> selectList(Map<String, Object> params);
    int selectCount(Map<String, Object> params);
    String selectMaxCode();
    Fac selectOne(String facCode);
    void insert(Fac fac);
    void update(Fac fac);
    void delete(String facCode);
}
