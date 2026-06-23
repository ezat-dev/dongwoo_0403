package com.sample_pro.dao.management;

import com.sample_pro.domain.Tester;
import java.util.List;
import java.util.Map;

public interface TesterInsertDao {
    List<Tester> selectList(Map<String, Object> params);
    int selectCount(Map<String, Object> params);
    String selectMaxCode();
    Tester selectOne(String terCode);
    void insert(Tester tester);
    void update(Tester tester);
    void delete(String terCode);
}
