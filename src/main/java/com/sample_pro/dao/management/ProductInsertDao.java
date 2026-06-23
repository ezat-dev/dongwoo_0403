package com.sample_pro.dao.management;

import com.sample_pro.domain.Product;
import java.util.List;
import java.util.Map;

public interface ProductInsertDao {
    List<Product> selectList(Map<String, Object> params);
    int selectCount(Map<String, Object> params);
    String selectMaxCode();
    Product selectOne(String prodCode);
    void insert(Product product);
    void update(Product product);
    void delete(String prodCode);
}
