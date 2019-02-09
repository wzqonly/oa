package com.oa.action;

import com.oa.domain.ResponseResult;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by zonly on 2019/2/6.
 */
public class BaseAction implements ServletRequestAware,ServletResponseAware {

    protected HttpServletRequest request;

    protected HttpServletResponse response;

    protected ResponseResult result;    //响应信息

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    public ResponseResult getResult() {
        return result;
    }

    public void setResult(ResponseResult result) {
        this.result = result;
    }

    @Override
    public void setServletResponse(HttpServletResponse httpServletResponse) {
        this.response = httpServletResponse;
    }
}
