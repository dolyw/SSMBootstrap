package com.wang.model;

import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableName;

@TableName("user")
public class User extends SuperEntity {
	private String account;
	private String password;
	private String username;
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
