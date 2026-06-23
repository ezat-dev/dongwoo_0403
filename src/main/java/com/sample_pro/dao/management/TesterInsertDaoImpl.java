package com.sample_pro.dao.management;

import com.sample_pro.domain.Tester;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Repository
public class TesterInsertDaoImpl implements TesterInsertDao {

    @Resource(name = "session")
    private SqlSession sqlSession;

    @Override public List<Tester> selectList(Map<String, Object> params) { return sqlSession.selectList("TesterMapper.selectList", params); }
    @Override public int selectCount(Map<String, Object> params) { return sqlSession.selectOne("TesterMapper.selectCount", params); }
    @Override public String selectMaxCode() { return sqlSession.selectOne("TesterMapper.selectMaxCode"); }
    @Override public Tester selectOne(String terCode) { return sqlSession.selectOne("TesterMapper.selectOne", terCode); }
    @Override public void insert(Tester tester) { sqlSession.insert("TesterMapper.insert", tester); }
    @Override public void update(Tester tester) { sqlSession.update("TesterMapper.update", tester); }
    @Override public void delete(String terCode) { sqlSession.delete("TesterMapper.delete", terCode); }
}
