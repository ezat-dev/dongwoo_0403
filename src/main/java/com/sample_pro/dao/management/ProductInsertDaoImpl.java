package com.sample_pro.dao.management;

import com.sample_pro.domain.Product;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Repository
public class ProductInsertDaoImpl implements ProductInsertDao {

    @Resource(name = "session")
    private SqlSession sqlSession;

    @Override
    public List<Product> selectList(Map<String, Object> params) {
        return sqlSession.selectList("ProductMapper.selectList", params);
    }

    @Override
    public int selectCount(Map<String, Object> params) {
        return sqlSession.selectOne("ProductMapper.selectCount", params);
    }

    @Override
    public String selectMaxCode() {
        return sqlSession.selectOne("ProductMapper.selectMaxCode");
    }

    @Override
    public Product selectOne(String prodCode) {
        return sqlSession.selectOne("ProductMapper.selectOne", prodCode);
    }

    @Override
    public void insert(Product product) {
        sqlSession.insert("ProductMapper.insert", product);
    }

    @Override
    public void update(Product product) {
        sqlSession.update("ProductMapper.update", product);
    }

    @Override
    public void delete(String prodCode) {
        sqlSession.delete("ProductMapper.delete", prodCode);
    }
}
