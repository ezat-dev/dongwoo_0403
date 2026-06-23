package com.sample_pro.service.management;

import com.sample_pro.dao.management.CorpInsertDao;
import com.sample_pro.domain.Corp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CorpInsertServiceImpl implements CorpInsertService {

    @Autowired
    private CorpInsertDao corpInsertDao;

    @Override
    public Map<String, Object> getList(Map<String, Object> params) {
        int page     = params.containsKey("page")     ? Integer.parseInt(params.get("page").toString())     : 1;
        int pageSize = params.containsKey("pageSize")  ? Integer.parseInt(params.get("pageSize").toString()) : 20;
        int offset   = (page - 1) * pageSize;
        params.put("offset",   offset);
        params.put("pageSize", pageSize);

        List<Corp> list  = corpInsertDao.selectList(params);
        int        total = corpInsertDao.selectCount(params);

        Map<String, Object> result = new HashMap<>();
        result.put("list",      list);
        result.put("total",     total);
        result.put("page",      page);
        result.put("pageSize",  pageSize);
        result.put("totalPage", (int) Math.ceil((double) total / pageSize));
        return result;
    }

    @Override
    public Corp getOne(String corpCode) {
        return corpInsertDao.selectOne(corpCode);
    }

    @Override
    public void save(Corp corp) {
        String code = corp.getCorp_code();
        if (code == null || code.trim().isEmpty()) {
            corp.setCorp_code(generateNextCode());
            corpInsertDao.insert(corp);
        } else {
            Corp existing = corpInsertDao.selectOne(code);
            if (existing == null) {
                corpInsertDao.insert(corp);
            } else {
                corpInsertDao.update(corp);
            }
        }
    }

    @Override
    public void delete(String corpCode) {
        corpInsertDao.delete(corpCode);
    }

    private String generateNextCode() {
        String maxCode = corpInsertDao.selectMaxCode();
        int next = 1;
        if (maxCode != null && maxCode.matches("C\\d+")) {
            next = Integer.parseInt(maxCode.substring(1)) + 1;
        }
        return String.format("C%04d", next);
    }
}
