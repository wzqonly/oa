package com.oa.dao.impl;

import com.oa.dao.IUserDao;
import com.oa.domain.PageInfo;
import com.oa.entity.Employee;
import com.oa.util.MD5keyUtil;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by zonly on 2019/1/31.
 */
@Repository
public class UserDaoImpl extends HibernateDaoSupport implements IUserDao {

    @Override
    public List<Employee> findEmpByCondition(Employee employee) {
        try{
            StringBuilder sql = new StringBuilder("from Employee where 1=1 ");
            List<Object> paramObj = new LinkedList<>();
            //用户名
            if(!StringUtils.isEmpty(employee.getUserName())){
                sql.append(" and userName = ? ");
                paramObj.add(employee.getUserName());
            }
            //密码
            if(!StringUtils.isEmpty(employee.getPassword())){
                sql.append(" and password = ? ");
                paramObj.add(employee.getPassword());
            }
            return (List<Employee>) getHibernateTemplate().
                    find(sql.toString(), paramObj.toArray());
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }

    @Override
    @Transactional
    public boolean insertEmployee(Employee employee) {
        try{
            //生成员工编号
            employee.setUserCode("20190202123");
            //初始化密码123456
            MD5keyUtil md5 = new MD5keyUtil();
            employee.setPassword(md5.getkeyBeanofStr("123456"));
            getHibernateTemplate().save(employee);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Employee> findEmpList(PageInfo pageInfo) {
        List<Employee> list = null;
        try{
            list = (List<Employee>) getHibernateTemplate().find("from Employee where 1=1");
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }


    @Resource(name="sessionFactory")
    public void setSessionFacotry(SessionFactory sessionFacotry) {
        super.setSessionFactory(sessionFacotry);
    }
}
