package com.wang.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import com.wang.util.JsonListUtil;
import com.wang.util.RedisKeys;
import io.swagger.annotations.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.plugins.Page;
import com.wang.model.User;
import com.wang.service.IUserService;
import springfox.documentation.annotations.ApiIgnore;

/**
 * User操作Controller
 * @Author Wang926454
 * @Date 2018/5/14 11:02
 */
@Controller
@RequestMapping("/user")
@Api(tags = "用户API")
public class UserController extends BaseController {
	
	private final IUserService userService;
    private RedisTemplate redisTemplate;

    @Autowired
    public UserController(IUserService userService, RedisTemplate redisTemplate) {
        this.userService = userService;
        this.redisTemplate = redisTemplate;
    }
	
    /**
     * 获取所有User
     * @param 
     * @return java.lang.String
     * @author Wang926454
     * @date 2018/7/30 15:53
     */
    @ApiIgnore
    @RequestMapping("/userList")
	public String userList() {
		return "admin/user/userList";
	}

	/**
	 * AJAX获取User
	 * @param pageNumber
	 * @param pageSize
	 * @param request
	 * @return java.lang.Object
	 * @author Wang926454
	 * @date 2018/7/30 15:53
	 */
    @ResponseBody
	@RequestMapping("/getUserList")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNumber", required = true, value = "页数", paramType = "query"),
            @ApiImplicitParam(name = "pageSize", required = true, value = "条数", paramType = "query")
    })
    @ApiOperation(value = "获取所有用户", httpMethod = "POST", notes = "详细描述：返回JSON获", response = Object.class)
    public Object getUserList(String pageNumber, String pageSize, HttpServletRequest request) {
        if(StringUtils.isBlank(pageNumber) && StringUtils.isBlank(pageSize)){
            pageNumber = "1";
            pageSize = "10";
        }
        // pageNumber--页数 pageSize--每页显示数据的条数
        Page<User> selectPage = userService
                .selectPage(new Page<User>(Integer.parseInt(pageNumber), Integer.parseInt(pageSize)));
        // bootstrap-table要求服务器返回的json须包含：total，rows，用rows一直接收不到，改成data好了。。。
        Map<String, Object> map = new HashMap<String, Object>(16);
        map.put("total", selectPage.getTotal());
        map.put("data", selectPage.getRecords());
        return map;
    }

    /**
     * 删除User
     * @param id
     * @return java.lang.Object
     * @author Wang926454
     * @date 2018/7/30 15:54
     */
	@ResponseBody
    @RequestMapping("/userDelete")
    @ApiImplicitParam(name = "id", required = true, value = "用户ID", paramType = "query")
    @ApiOperation(value = "删除单个用户", httpMethod = "POST", notes = "详细描述：根据ID删除单个用户返回JSON", response = com.wang.util.JsonResult.class)
    public Object userDelete(Long id) throws Exception{
        if (id != null) {
            if(redisTemplate.hasKey(RedisKeys.getUserKey(id.toString()))){
                redisTemplate.delete(RedisKeys.getUserKey(id.toString()));
            }
            return userService.deleteById(id) ? renderSuccess("删除成功") : renderError("删除失败");
        }
        return renderError("删除失败");

    }

    /**
     * 编辑User
     * @param model
	 * @param id
     * @return java.lang.String
     * @author Wang926454
     * @date 2018/7/30 15:54
     */
	@RequestMapping("/userEdit")
    @ApiIgnore
    public String userEdit(Model model, @RequestParam(value = "id", required = false) Long id) throws Exception{
		if (id != null) {
		    if(redisTemplate.hasKey(RedisKeys.getUserKey(id.toString()))){
                model.addAttribute("user", JsonListUtil.jsonToObject(
                        (String) redisTemplate.opsForValue().get("user:" + id), User.class));
            }else{
                User user = userService.selectById(id);
                redisTemplate.opsForValue().set(RedisKeys.getUserKey(user.getId().toString()), JsonListUtil.objectToJson(user));
		        model.addAttribute("user", user);
            }
        }
		return "admin/user/userEdit";
    }

    /**
     * 新增User
     * @param user
     * @return java.lang.Object
     * @author Wang926454
     * @date 2018/7/30 15:54
     */
	@ResponseBody
    @RequestMapping("/userSave")
    /**
     * @ApiResponses({
            @ApiResponse(code = 200, message = "成功"),
            @ApiResponse(code = 204, message = "没有返回任何信息"),
            @ApiResponse(code = 401, message = "没有权限")
    })
     */
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", required = false, value = "用户ID", paramType = "query"),
            @ApiImplicitParam(name = "account", required = false, value = "帐号", paramType = "query"),
            @ApiImplicitParam(name = "password", required = false, value = "密码", paramType = "query"),
            @ApiImplicitParam(name = "username", required = false, value = "用户名", paramType = "query")
    })
    @ApiOperation(value = "添加或修改用户信息", httpMethod = "POST", notes = "详细描述：返回JSON", response = com.wang.util.JsonResult.class)
    public Object userSave(@ApiIgnore User user) throws Exception {
        if (user.getId() == null) {
        	user.setRegtime(new Date());
            return userService.insert(user) ? renderSuccess("添加成功") : renderError("添加失败");
        } else {
            if(redisTemplate.hasKey(RedisKeys.getUserKey(user.getId().toString()))){
                redisTemplate.delete(RedisKeys.getUserKey(user.getId().toString()));
            }
            return userService.updateById(user) ? renderSuccess("修改成功") : renderError("修改失败");
        }
    }
}
