package com.oa.action;

import com.oa.entity.Employee;
import com.oa.service.IUserService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

/**
 * Created by zonly on 2019/1/31.
 */
@Controller("userAction")
@Scope("prototype")
public class UserAction {

    @Resource
    private IUserService userService;

    private Employee employee;


    public String login(){
        Employee emp = userService.login(employee);
       /* if(emp != null){
            return "success";
        }
        return "input";*/
        return "success";
    }

    public String loginout(){
        return "loginout";
    }


    public void setEmployee(Employee employee) {
        this.employee = employee;
    }
}
