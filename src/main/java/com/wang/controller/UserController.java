package com.wang.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import io.swagger.annotations.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.baomidou.mybatisplus.plugins.Page;
import com.wang.model.User;
import com.wang.service.IUserService;
import springfox.documentation.annotations.ApiIgnore;

/**
 * @Desc User操作Controller
 * @Author Wang926454
 * @Date 2018/5/14 11:02
 */
@Controller
@RequestMapping("/user")
@Api(tags = "用户API")
public class UserController extends BaseController {
	
	private final IUserService userService;

    @Autowired
    public UserController(IUserService userService) {
        this.userService = userService;
    }
	
    /**
     * 获取所有User
     * @param model
     * @return
     * @throws Exception
     */
	// 直接获取User
    /*@RequestMapping("/userList")
	public String userList(Model model) throws Exception{
		List<User> userList = userService.selectList(null);
		model.addAttribute("userList", userList);
		return "admin/user/userList";
	}*/
    // AJAX获取User
    @ApiIgnore
    @RequestMapping("/userList")
	public String userList() {
		return "admin/user/userList";
	}

    @ResponseBody
	@RequestMapping("/getUserList")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNumber", required = true, value = "页数", dataType = "String"),
            @ApiImplicitParam(name = "pageSize", required = true, value = "条数", dataType = "String")
    })
    @ApiOperation(value = "获取所有用户", httpMethod = "GET", notes = "获取所有用户返回JSON")
    public Object getUserList(String pageNumber, String pageSize, HttpServletRequest request) {
        if(!StringUtils.isNotBlank(pageNumber) & !StringUtils.isNotBlank(pageSize)){
            pageNumber="1";
            pageSize="10";
        }
        // 分页 pageNumber--》页数    pageSize--》每页显示数据的条数
        Page<User> selectPage = userService
                .selectPage(new Page<User>(Integer.parseInt(pageNumber), Integer.parseInt(pageSize)));
        // bootstrap-table要求服务器返回的json须包含：total，rows，用rows一直接收不到，改成data好了。。。
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("total", selectPage.getTotal());
        map.put("data", selectPage.getRecords());
        return map;
    }

    /**
     * 删除User
     * @param id
     * @return
     */
	@ResponseBody
    @RequestMapping("/userDelete")
    @ApiImplicitParam(name = "id", required = true, value = "用户ID", dataType = "Long")
    @ApiOperation(value = "删除单个用户", httpMethod = "GET", notes = "根据ID删除单个用户返回JSON")
    public Object userDelete(@RequestParam(value = "id") Long id) {
        return userService.deleteById(id) ? renderSuccess("删除成功") : renderError("删除失败");
    }

    /**
     * 编辑User
     * @param model
     * @param id
     * @return
     */
	@RequestMapping("/userEdit")
    @ApiIgnore
    public String userEdit(Model model, @RequestParam(value = "id", required = false) Long id) {
		if (id != null) {
			model.addAttribute("user", userService.selectById(id));
        }
		return "admin/user/userEdit";
    }

    /**
     * 新增User
     * @param user
     * @return
     */
	@ResponseBody
    @RequestMapping("/userSave")
    @ApiResponses({
            @ApiResponse(code = 200, message = "成功"),
            @ApiResponse(code = 204, message = "没有返回任何信息"),
            @ApiResponse(code = 401, message = "没有权限")
    })
    @ApiOperation(value = "添加或修改用户信息", httpMethod = "GET", notes = "添加或修改用户信息返回JSON")
    public Object userSave(User user) {
        if (user.getId() == null) {
        	user.setRegtime(new Date());
            return userService.insert(user) ? renderSuccess("添加成功") : renderError("添加失败");
        } else {
            return userService.updateById(user) ? renderSuccess("修改成功") : renderError("修改失败");
        }
    }
}
