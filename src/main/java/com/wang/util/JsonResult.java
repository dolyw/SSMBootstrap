package com.wang.util;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * Author: D.Yang
 * Email: koyangslash@gmail.com
 * Date: 16/8/31
 * Time: 下午5:50
 * Describe: 封装Json返回信息
 * @Author: Wang926454
 */
@ApiModel(value="JsonResult",description="Json对象")
public class JsonResult {
    @ApiModelProperty(value="状态",name="success")
    private boolean success;
    @ApiModelProperty(value="状态码",name="status")
    private String status;
    @ApiModelProperty(value="信息",name="msg")
    private String msg;
    @ApiModelProperty(value="对象",name="obj")
    private Object obj;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }
}
