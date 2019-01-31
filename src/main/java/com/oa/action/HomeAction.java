package com.oa.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

/**
 * Created by zonly on 2019/1/31.
 */
@Controller("homeAction")
@Scope("prototype")
public class HomeAction {

    public String left(){
        return "left";
    }

    public String top(){
        return "top";
    }

    public String rightTop(){
        return "rightTop";
    }

    public String welcome(){
        return "welcome";
    }
}
