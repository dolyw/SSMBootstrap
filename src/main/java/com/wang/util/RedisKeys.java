package com.wang.util;

/**
 * @Desc 获取Redis的Key
 * @Author Wang926454
 * @Date 2018/7/30 10:38
 */
public class RedisKeys {
    /**
     * @Desc 获取用户ID
     * @Author Wang926454
     * @Date 2018/7/30 10:39
     */
    public static String getUserKey(String key){
        return "user:" + key;
    }
}
