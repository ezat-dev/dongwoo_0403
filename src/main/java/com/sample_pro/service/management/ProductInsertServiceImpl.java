package com.sample_pro.service.management;

import com.sample_pro.dao.management.ProductInsertDao;
import com.sample_pro.domain.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductInsertServiceImpl implements ProductInsertService {

    @Autowired
    private ProductInsertDao productInsertDao;

    @Override
    public Map<String, Object> getList(Map<String, Object> params) {
        int page     = params.containsKey("page")     ? Integer.parseInt(params.get("page").toString())     : 1;
        int pageSize = params.containsKey("pageSize")  ? Integer.parseInt(params.get("pageSize").toString()) : 20;
        int offset   = (page - 1) * pageSize;
        params.put("offset",   offset);
        params.put("pageSize", pageSize);

        List<Product> list  = productInsertDao.selectList(params);
        int           total = productInsertDao.selectCount(params);

        Map<String, Object> result = new HashMap<>();
        result.put("list",      list);
        result.put("total",     total);
        result.put("page",      page);
        result.put("pageSize",  pageSize);
        result.put("totalPage", (int) Math.ceil((double) total / pageSize));
        return result;
    }

    @Override
    public Product getOne(String prodCode) {
        return productInsertDao.selectOne(prodCode);
    }

    @Override
    public void save(Product product) {
        String code = product.getProd_code();
        if (code == null || code.trim().isEmpty()) {
            product.setProd_code(generateNextCode());
            productInsertDao.insert(product);
        } else {
            Product existing = productInsertDao.selectOne(code);
            if (existing == null) {
                productInsertDao.insert(product);
            } else {
                productInsertDao.update(product);
            }
        }
    }

    private String generateNextCode() {
        String maxCode = productInsertDao.selectMaxCode();
        int next = 1;
        if (maxCode != null && maxCode.matches("P\\d+")) {
            next = Integer.parseInt(maxCode.substring(1)) + 1;
        }
        return String.format("P%04d", next);
    }

    @Override
    public void delete(String prodCode) {
        productInsertDao.delete(prodCode);
    }
}
