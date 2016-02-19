//
//  UserModel.h
//  lovelive
//
//  Created by ZMB on 15/12/1.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

//login_uid=用户ID
//login_token=令牌
//nickname=昵称
//gender=性别（0=女，1=男）
//birthday=生日（yyyy-MM-dd）
//nation=国家
//province=省份
//city=城市
//nationality=国籍
//signature=签名
//avatar=头像


@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *gender;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *nation;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *nationality;
@property (copy, nonatomic) NSString *signature;
@property (copy, nonatomic) NSString *avatar;
@property (copy, nonatomic) NSString *moeny;
@property (copy, nonatomic) NSArray *tags;                //标签
@property (copy, nonatomic) NSString *teacherClasses;     //我的教学
@property (copy, nonatomic) NSString *studyClasses;       //我的课程
@property (copy, nonatomic) NSString *subscribe;          // 预约
@property (copy, nonatomic) NSString *following;          //我关注的(见attention_count)
@property (copy, nonatomic) NSString *fans;               //关注我的
@property (copy, nonatomic) NSString *isShow;             //是否正在直播
@property (copy, nonatomic) NSString *user_type;            //用户类型
@property (copy, nonatomic) NSString *verify_status;        //认证状态
@property (assign, nonatomic) int notice_status;        // 是否已经关注(0:否，1：是)
@property (copy, nonatomic) NSString *subscribe_count;      // 预约课程数量
@property (copy, nonatomic) NSString *teach_count;          // 教学课程数量
@property (copy, nonatomic) NSString *attention_count;      // 关注的人数量
@property (copy, nonatomic) NSString *fans_count;           // 粉丝数量
@property (copy, nonatomic) NSString *evaluate_star;
@property (copy, nonatomic) NSString *online_status;        //在线状态
@property (copy, nonatomic) NSString *uid;                  //用户id
@property (copy, nonatomic) NSString *introduce;            //个人介绍
@property (copy, nonatomic) NSString *teaching_direction;   //教学方向
@property (copy, nonatomic) NSString *charging_standard;    //收费标准（元/分钟）
@property (copy, nonatomic) NSString *hot_tag;              //热门标签
@property (copy, nonatomic) NSString *user_grade;           //用户等级
@property (copy, nonatomic) NSString *singlelive_unit_price; //一对一收费标准（/分钟）
@property (copy, nonatomic) NSString *multilive_unit_price;  //直播收费单价（/分钟）
@property (copy, nonatomic) NSString *label;                 //用户自选标签
@property (assign, nonatomic) int latestFansCount;             //最新粉丝数量
@property (assign, nonatomic) long updateTime;               //更新时间

+(UserModel *)sharedInstance;
- (UserModel *) initWithDic:(NSDictionary *)dic;
// 检查是否需要更新
- (BOOL) isNeedUpdate;
@end
