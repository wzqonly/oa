package com.oa.dao.impl;

import com.oa.dao.IUserDao;
import com.oa.entity.Employee;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
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


    @Resource(name="sessionFactory")
    public void setSessionFacotry(SessionFactory sessionFacotry) {
        super.setSessionFactory(sessionFacotry);
    }
}
