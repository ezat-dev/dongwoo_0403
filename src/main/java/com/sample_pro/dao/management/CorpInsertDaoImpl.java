package com.sample_pro.dao.management;

import com.sample_pro.domain.Corp;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Repository
public class CorpInsertDaoImpl implements CorpInsertDao {

    @Resource(name = "session")
    private SqlSession sqlSession;

    @Override
    public List<Corp> selectList(Map<String, Object> params) {
        return sqlSession.selectList("CorpMapper.selectList", params);
    }

    @Override
    public int selectCount(Map<String, Object> params) {
        return sqlSession.selectOne("CorpMapper.selectCount", params);
    }

    @Override
    public String selectMaxCode() {
        return sqlSession.selectOne("CorpMapper.selectMaxCode");
    }

    @Override
    public Corp selectOne(String corpCode) {
        return sqlSession.selectOne("CorpMapper.selectOne", corpCode);
    }

    @Override
    public void insert(Corp corp) {
        sqlSession.insert("CorpMapper.insert", corp);
    }

    @Override
    public void update(Corp corp) {
        sqlSession.update("CorpMapper.update", corp);
    }

    @Override
    public void delete(String corpCode) {
        sqlSession.delete("CorpMapper.delete", corpCode);
    }
}
