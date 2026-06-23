package com.sample_pro.service.management;

import com.sample_pro.dao.management.FacInsertDao;
import com.sample_pro.domain.Fac;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FacInsertServiceImpl implements FacInsertService {

    @Autowired
    private FacInsertDao facInsertDao;

    @Override
    public Map<String, Object> getList(Map<String, Object> params) {
        int page     = params.containsKey("page")     ? Integer.parseInt(params.get("page").toString())     : 1;
        int pageSize = params.containsKey("pageSize")  ? Integer.parseInt(params.get("pageSize").toString()) : 20;
        int offset   = (page - 1) * pageSize;
        params.put("offset",   offset);
        params.put("pageSize", pageSize);

        List<Fac> list  = facInsertDao.selectList(params);
        int       total = facInsertDao.selectCount(params);

        Map<String, Object> result = new HashMap<>();
        result.put("list",      list);
        result.put("total",     total);
        result.put("page",      page);
        result.put("pageSize",  pageSize);
        result.put("totalPage", (int) Math.ceil((double) total / pageSize));
        return result;
    }

    @Override
    public Fac getOne(String facCode) {
        return facInsertDao.selectOne(facCode);
    }

    @Override
    public void save(Fac fac) {
        String code = fac.getFac_code();
        if (code == null || code.trim().isEmpty()) {
            fac.setFac_code(generateNextCode());
            facInsertDao.insert(fac);
        } else {
            Fac existing = facInsertDao.selectOne(code);
            if (existing == null) {
                facInsertDao.insert(fac);
            } else {
                facInsertDao.update(fac);
            }
        }
    }

    @Override
    public void delete(String facCode) {
        facInsertDao.delete(facCode);
    }

    private String generateNextCode() {
        String maxCode = facInsertDao.selectMaxCode();
        int next = 1;
        if (maxCode != null && maxCode.matches("F\\d+")) {
            next = Integer.parseInt(maxCode.substring(1)) + 1;
        }
        return String.format("F%04d", next);
    }
}
