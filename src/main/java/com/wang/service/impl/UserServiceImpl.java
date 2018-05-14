package com.wang.service.impl;

import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wang.mapper.UserMapper;
import com.wang.model.User;
import com.wang.service.IUserService;

/**
 * @Desc UserService实现类
 * @Author Wang926454
 * @Date 2018/5/14 11:10
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

}
