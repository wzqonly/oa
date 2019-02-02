package com.oa.service;

import com.oa.domain.PageInfo;
import com.oa.domain.ResponseResult;
import com.oa.entity.Employee;

import java.util.List;

/**
 * Created by zonly on 2019/1/31.
 */
public interface IUserService {

    Employee login(Employee employee);

    ResponseResult addUser(Employee employee);

    List<Employee> querylist(PageInfo pageInfo);
}
