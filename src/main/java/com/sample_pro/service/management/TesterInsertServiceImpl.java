package com.sample_pro.service.management;

import com.sample_pro.dao.management.TesterInsertDao;
import com.sample_pro.domain.Tester;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TesterInsertServiceImpl implements TesterInsertService {

    @Autowired
    private TesterInsertDao testerInsertDao;

    @Override
    public Map<String, Object> getList(Map<String, Object> params) {
        int page     = params.containsKey("page")     ? Integer.parseInt(params.get("page").toString())     : 1;
        int pageSize = params.containsKey("pageSize")  ? Integer.parseInt(params.get("pageSize").toString()) : 20;
        int offset   = (page - 1) * pageSize;
        params.put("offset",   offset);
        params.put("pageSize", pageSize);
        List<Tester> list  = testerInsertDao.selectList(params);
        int          total = testerInsertDao.selectCount(params);
        Map<String, Object> result = new HashMap<>();
        result.put("list",      list);
        result.put("total",     total);
        result.put("page",      page);
        result.put("pageSize",  pageSize);
        result.put("totalPage", (int) Math.ceil((double) total / pageSize));
        return result;
    }

    @Override
    public Tester getOne(String terCode) { return testerInsertDao.selectOne(terCode); }

    @Override
    public void save(Tester tester) {
        String code = tester.getTer_code();
        if (code == null || code.trim().isEmpty()) {
            tester.setTer_code(generateNextCode());
            testerInsertDao.insert(tester);
        } else {
            Tester existing = testerInsertDao.selectOne(code);
            if (existing == null) testerInsertDao.insert(tester);
            else                  testerInsertDao.update(tester);
        }
    }

    @Override
    public void delete(String terCode) { testerInsertDao.delete(terCode); }

    private String generateNextCode() {
        String maxCode = testerInsertDao.selectMaxCode();
        int next = 1;
        if (maxCode != null && maxCode.matches("T\\d+")) {
            next = Integer.parseInt(maxCode.substring(1)) + 1;
        }
        return String.format("T%04d", next);
    }
}
