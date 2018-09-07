package com.wang.util;

/**
 * 获取Redis的Key
 * @Author Wang926454
 * @Date 2018/7/30 10:38
 */
public class RedisKeys {
    /**
     * 获取用户ID
     * @param key
     * @return java.lang.String
     * @author Wang926454
     * @date 2018/7/30 15:53
     */
    public static String getUserKey(String key){
        return "user:" + key;
    }
}
