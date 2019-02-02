package com.oa.service.impl;

import com.oa.dao.IUserDao;
import com.oa.domain.PageInfo;
import com.oa.domain.ResponseResult;
import com.oa.entity.Employee;
import com.oa.service.IUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by zonly on 2019/1/31.
 */
@Service
public class UserServiceImpl implements IUserService {

    @Resource
    private IUserDao userDao;

    @Override
    public Employee login(Employee employee) {
        try {
            Employee emp = null;
            List<Employee> list = userDao.findEmpByCondition(employee);
            if(null != list && !list.isEmpty()){
                emp = list.get(0);
            }
            return emp;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public ResponseResult addUser(Employee employee) {
        try{
            boolean result = userDao.insertEmployee(employee);
            if(result){
                return new ResponseResult<>(true,"添加员工成功");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return new ResponseResult<>(false,"添加员工失败");
    }

    @Override
    public List<Employee> querylist(PageInfo pageInfo) {
        try{
            List<Employee> list = userDao.findEmpList(pageInfo);
            return list;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
