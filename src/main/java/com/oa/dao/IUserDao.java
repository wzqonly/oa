package com.oa.dao;

import com.oa.domain.PageInfo;
import com.oa.entity.Employee;

import java.util.List;

/**
 * Created by zonly on 2019/1/31.
 */
public interface IUserDao {

    List<Employee> findEmpByCondition(Employee employee);

    boolean insertEmployee(Employee employee);

    List<Employee> findEmpList(PageInfo pageInfo);
}
