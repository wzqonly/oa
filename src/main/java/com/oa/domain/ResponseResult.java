package com.oa.domain;

import java.util.List;

/**
 * 响应实体
 */
public class ResponseResult<T> {

    private boolean success; //是否成功
    private String message;    //提示信息
    private List<T> data;     //数据集合
    public ResponseResult(){

    }

    public ResponseResult(boolean success, String message){
        this.success = success;
        this.message = message;
    }

    public ResponseResult(boolean success, String message, List<T> data){
        this.success = success;
        this.message = message;
        this.data = data;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<?> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }
}
