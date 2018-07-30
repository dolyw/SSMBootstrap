package com.wang.model;

import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * @Desc User
 * @Author: Wang926454
 * @Date 2018/7/30 10:44
 */
@TableName("user")
@ApiModel(value="User",description="用户对象user")
public class User extends SuperEntity {

	@ApiModelProperty(value="帐号",name="account")
	private String account;
	@ApiModelProperty(value="密码",name="password")
	private String password;
	@ApiModelProperty(value="用户名",name="username")
	private String username;
	@ApiModelProperty(value="注册时间",name="regtime")
	private Date regtime;
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Date getRegtime() {
		return regtime;
	}
	public void setRegtime(Date regtime) {
		this.regtime = regtime;
	}
	
}
