package com.sample_pro.service.management;

import com.sample_pro.domain.Product;
import java.util.Map;

public interface ProductInsertService {
    Map<String, Object> getList(Map<String, Object> params);
    Product getOne(String prodCode);
    void save(Product product);
    void delete(String prodCode);
}
