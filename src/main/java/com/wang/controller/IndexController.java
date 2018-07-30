package com.wang.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import springfox.documentation.annotations.ApiIgnore;

/**
 * TODO：IndexController
 * @author Wang926454
 * @date 2018/7/30 15:50
 */
@Controller
@RequestMapping("/index")
@ApiIgnore
public class IndexController extends BaseController {

	@RequestMapping("/index")
	public String index() throws Exception{
		return "admin/index";
	}
}
