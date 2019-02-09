package com.oa.action;

import com.oa.domain.PageInfo;
import com.oa.domain.ResponseResult;
import com.oa.entity.Employee;
import com.oa.service.IUserService;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by zonly on 2019/1/31.
 */
@Controller("userAction")
@Scope("prototype")
public class UserAction implements ServletRequestAware{

    @Resource
    private IUserService userService;

    private Employee employee;

    private ResponseResult result;    //响应信息

    private PageInfo pageInfo;  //分页对象

    private HttpServletRequest request;

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

    public String list(){
        List<Employee> list = userService.querylist(pageInfo);
        request.setAttribute("list",list);
        return "list";
    }

    public String add(){
        result = userService.addUser(employee);
        return "message";
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public ResponseResult getResult() {
        return result;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setResult(ResponseResult result) {
        this.result = result;
    }

    public PageInfo getPageInfo() {
        return pageInfo;
    }

    public void setPageInfo(PageInfo pageInfo) {
        this.pageInfo = pageInfo;
    }


    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }


}
