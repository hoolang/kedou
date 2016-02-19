//
//  EnumDefine.h
//  lovelive
//
//  Created by TerryChao on 15/12/18.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//  枚举定义

#ifndef EnumDefine_h
#define EnumDefine_h

// 课程类型
enum CourseForType
{
    
    //kCourse_Common = 0,       // 公用的
    kCourse_UnTeach = 1,        // 未完成教学
    kCourse_Teach = 2,          // 已完成教学
    kCourse_MyYuYue = 3,        // 我的预约(学生)
    kCourse_TheTeacher = 4,     // 指定老师课程
    kCourse_My_OneToOne = 5,    // 我的课程-一对一
    kCourse_My_Live = 6,        // 我的课程-直播
};

// 直播状态（0：未开始，1：直播中，2：已结束，3：已取消）
typedef NS_ENUM(NSInteger, LIVE_STATUS)
{
    LIVE_STATUS_NIL = 0, // 空 nil,null
    LIVE_STATUS_UN_START = 0,
    LIVE_STATUS_LIVING = 1,
    LIVE_STATUS_END = 2,
    LIVE_STATUS_CANCEL = 3,
};

// 类型（1：直播，2：一对一）
typedef NS_ENUM(NSInteger, LIVE_TYPE)
{
    LIVE_TYPE_LIVE = 1,
    LIVE_TYPE_ONE_TO_ONE = 2,
};


// 常用状态
typedef NS_ENUM(NSInteger, COMMON_STATUS)
{
    COMMON_STATUS_NO = 0,
    COMMON_STATUS_YES = 1,
};

// 常用状态
typedef NS_ENUM(NSInteger, API_STATUS)
{
    API_OK = 0,
    API_NOT_SUFFICIENT_FUNDS = 306, // 余额不足
    API_STATUS_TOKEN_EXPIRE = 208, // 登录过期
};

// 认证状态 老师认证状态（-1：未申请，0：已申请，1：已通过，2：不通过）
typedef NS_ENUM(NSInteger, VERIFY_STATUS)
{
    VERIFY_STATUS_DEFAULT = -1,
    VERIFY_STATUS_APPLY = 0,
    VERIFY_STATUS_SUCCESS = 1,
    VERIFY_STATUS_FAILED = 2,
    
};

// 在线状态（1：在线，5：连接中，9：离线）
typedef enum{
    
    OFFLINE_STATUS = 9,
    ONLINE_STATUS = 1,
    LINKING_STATUS = 5
}ONLINE_STATUS_TYPE;

// 用户类型（1：学生，2：老师）
typedef enum{
    STUDENT = 1,
    TEACHER = 2,
}USER_TYPE;

// 性别类型（0：女， 1：男）
typedef enum {
    Male = 1,       //男性
    Female = 0,     //女性
} GenderType;

//recharge_type:充值类型， 1：微信，2：paypal，3：苹果支付
typedef NS_ENUM(NSInteger, BANK_TYPE)
{
    BACK_TYPE_WECHAT = 1,
    BACK_TYPE_PAYPAL = 2,
    BACK_TYPE_APPLE = 3,
};

// 1：微博，2：微信，3：QQ，4：facebook
enum ThreeParty
{
    THREE_PARTY_WEIBO = 1,         /**< 新浪微博 */
    THREE_PARTY_WECHAT = 2,
    THREE_PARTY_QQ = 3,
    THREE_PARTY_FACEBOOK = 4,
};
// 首页列表类型（0：首页，1：所有直播列表，2：用户动态列表）
typedef enum{
    HOME_TYPE_HOME = 0,
    HOME_TYPE_LIVE = 1,
    HOME_TYPE_USER = 2,
}HOME_TYPE;
#endif /* EnumDefine_h */
