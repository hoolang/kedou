//
//  Member.m
//  lovelive
//
//  Created by Kong on 15/11/25.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LoginUserModel.h"

@implementation LoginUserModel

@synthesize login_uid, login_token;


- (LoginUserModel *) initWithDic:(NSDictionary *)dic{
    return [self formatMemberWithDic:dic];
}

-(LoginUserModel *) formatMemberWithDic:(NSDictionary *)dic{
    LoginUserModel *model = [[LoginUserModel alloc] init];
    model.login_uid =  [self getStringValueInDic:dic key:@"login_uid" ] ;
    model.login_token = [ self getStringValueInDic:dic key:@"login_token"];
    model.tls_usersin = [ self getStringValueInDic:dic key:@"tls_usersin"];
    model.phone = [ self getStringValueInDic:dic key:@"phone"];
    model.user_type = [ self getStringValueInDic:dic key:@"user_type"];
    model.nickname = [ self getStringValueInDic:dic key:@"nickname"];
    model.gender = [ self getStringValueInDic:dic key:@"gender"];
    model.birthday = [ self getStringValueInDic:dic key:@"birthday"];
    model.nation = [ self getStringValueInDic:dic key:@"nation"];
    model.province = [ self getStringValueInDic:dic key:@"province"];
    model.city = [ self getStringValueInDic:dic key:@"city"];
    model.nationality = [ self getStringValueInDic:dic key:@"nationality"];
    model.signature = [ self getStringValueInDic:dic key:@"signature"];
    model.avatar = [ self getStringValueInDic:dic key:@"avatar"];
    model.register_time = [ self getStringValueInDic:dic key:@"register_time"];
    model.introduce = [ self getStringValueInDic:dic key:@"introduce"];
    model.teaching_direction = [ self getStringValueInDic:dic key:@"teaching_direction"];
    model.charging_standard = [ self getStringValueInDic:dic key:@"charging_standard"];
    model.evaluate_star = [ self getStringValueInDic:dic key:@"evaluate_star"];
    model.online_status = [ self getStringValueInDic:dic key:@"online_status"];
    model.verify_status = [ self getStringValueInDic:dic key:@"verify_status"];
    model.notice_status = [ self getStringValueInDic:dic key:@"notice_status"];
    return model;
}

@end


