package com.wang.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Desc 主页
 * @Author Wang926454
 * @Date 2018/5/14 11:01
 */
@Controller
@RequestMapping("/index")
public class IndexController extends BaseController {

	@RequestMapping("/index")
	public String index() throws Exception{
		return "admin/index";
	}
}
