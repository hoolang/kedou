//
//  UserModel.m
//  lovelive
//
//  Created by ZMB on 15/12/1.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "UserModel.h"

#define USER_INFO_CACHE_TIME 60*60*5

@implementation UserModel
+(UserModel *)sharedInstance{
    static UserModel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserModel alloc] init];
    });
    return instance;
}
@synthesize fans;

- (UserModel *) initWithDic:(NSDictionary *)dic{
    return [self formatWithDic:dic];
}

-(UserModel *) formatWithDic:(NSDictionary *)dic{
    
    UserModel *model = [[UserModel alloc] init];
    
    model.uid = [self getStringValueInDic:dic key:@"uid"];
    model.phone = [self getStringValueInDic:dic key:@"phone"];
    model.nickname = [self getStringValueInDic:dic key:@"nickname"];
    model.gender = [self getStringValueInDic:dic key:@"gender"];
    model.birthday = [self getStringValueInDic:dic key:@"birthday"];
    model.nation = [self getStringValueInDic:dic key:@"nation"];
    model.province = [self getStringValueInDic:dic key:@"province"];
    model.city = [self getStringValueInDic:dic key:@"city"];
    model.nationality = [self getStringValueInDic:dic key:@"nationality"];
    model.signature = [self getStringValueInDic:dic key:@"signature"];
    model.avatar = [self getStringValueInDic:dic key:@"avatar"];
    model.moeny = [self getStringValueInDic:dic key:@"moeny"];
    model.tags =  [[self getStringValueInDic:dic key:@"hot_tag"] componentsSeparatedByString:@","];
    model.teacherClasses = [self getStringValueInDic:dic key:@"teacherClasses"];
    model.studyClasses = [self getStringValueInDic:dic key:@"studyClasses"];
    model.subscribe = [self getStringValueInDic:dic key:@"subscribe"];
    model.following = [self getStringValueInDic:dic key:@"following"];
    model.fans = [self getStringValueInDic:dic key:@"fans"];
    model.isShow = [self getStringValueInDic:dic key:@"isShow"];
    model.user_type = [self getStringValueInDic:dic key:@"user_type"];
    model.verify_status = [self getStringValueInDic:dic key:@"verify_status"];
    model.evaluate_star = [self getStringValueInDic:dic key:@"evaluate_star"];
    model.online_status = [self getStringValueInDic:dic key:@"online_status"];
    model.notice_status = (int)[self getIntValueInDic:dic key:@"notice_status"];
    model.subscribe_count = [self getStringValueInDic:dic key:@"subscribe_count"];
    model.teach_count = [self getStringValueInDic:dic key:@"teach_count"];
    model.attention_count = [self getStringValueInDic:dic key:@"attention_count"];
    model.fans_count = [self getStringValueInDic:dic key:@"fans_count"];
    
    model.uid = [self getStringValueInDic:dic key:@"uid"];
    model.introduce = [self getStringValueInDic:dic key:@"introduce"];
    model.teaching_direction = [self getStringValueInDic:dic key:@"teaching_direction"];
    model.charging_standard = [self getStringValueInDic:dic key:@"charging_standard"];
    model.user_grade = [self getStringValueInDic:dic key:@"user_grade"];
    model.hot_tag = [self getStringValueInDic:dic key:@"hot_tag"];
    model.singlelive_unit_price = [self getStringValueInDic:dic key:@"singlelive_unit_price"];
    model.multilive_unit_price = [self getStringValueInDic:dic key:@"multilive_unit_price"];
    model.label = [self getStringValueInDic:dic key:@"label"];
    
    // 赋值给当前时间
    model.updateTime = (long)[[NSDate date] timeIntervalSince1970];
    return model;
}

- (BOOL) isNeedUpdate {
    BOOL isUpdate = false;
    
    long curTime = (long)[[NSDate date] timeIntervalSince1970];
    if (curTime - self.updateTime > USER_INFO_CACHE_TIME) {
        isUpdate = true;
    }
    
    return isUpdate;
}


@end
