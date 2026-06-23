package com.sample_pro.dao.management;

import com.sample_pro.domain.Fac;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Repository
public class FacInsertDaoImpl implements FacInsertDao {

    @Resource(name = "session")
    private SqlSession sqlSession;

    @Override
    public List<Fac> selectList(Map<String, Object> params) {
        return sqlSession.selectList("FacMapper.selectList", params);
    }

    @Override
    public int selectCount(Map<String, Object> params) {
        return sqlSession.selectOne("FacMapper.selectCount", params);
    }

    @Override
    public String selectMaxCode() {
        return sqlSession.selectOne("FacMapper.selectMaxCode");
    }

    @Override
    public Fac selectOne(String facCode) {
        return sqlSession.selectOne("FacMapper.selectOne", facCode);
    }

    @Override
    public void insert(Fac fac) {
        sqlSession.insert("FacMapper.insert", fac);
    }

    @Override
    public void update(Fac fac) {
        sqlSession.update("FacMapper.update", fac);
    }

    @Override
    public void delete(String facCode) {
        sqlSession.delete("FacMapper.delete", facCode);
    }
}
