//
//  LoginMgr.m
//  lovelive
//
//  Created by Kong on 15/11/25.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//
#import "LoginMgr.h"
#import "UserMgr.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "DeviceMgr.h"
#import "UIImageView+WebCache.h"
#import "ThemeCategoriesModel.h"

@interface LoginMgr(){
    BOOL isTlsImStart;
}

@end

@implementation LoginMgr

#define KEY_LOGIN_MEMBER_INFO @"KEY_LOGIN_MEMBER_INFO"
#define KEY_LOGIN_LOCAL_INFO @"KEY_LOGIN_LOCAL_INFO"

+(LoginMgr *)sharedInstance{
    static LoginMgr *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LoginMgr alloc] init];
    });
    return instance;
}


- (BOOL) isLogin{
    LoginUserModel *user = [self getLoginUserInfo];
    if ([user.login_uid intValue] > 0) {
        return YES;
    }
    return NO;
}

// 清除本地缓存
-(void) logout{
    LoginUserModel *userModel = [[LoginUserModel alloc] init];
    userModel.login_uid = 0;
    userModel.phone = [self getLoginUserInfo].phone;
    [self saveLoginUserInfo:userModel];
    [NotificationUtil postNotification:LOG_OUT object:nil userinfo:nil];
}


// 取服务器时间，根据偏移量计算得出
-(NSTimeInterval) getServerTime{
    return [[NSDate date] timeIntervalSince1970] - localWithServerTimeOffset;
}

/**
 *  获取用户id
 *
 *  @return 用户id
 */
- (NSString *) getLoginId{
    return [NSString stringWithFormat:@"%@", [self getLoginUserInfo].login_uid ];
}

- (void) saveLoginUserInfo:(LoginUserModel *)loginuser{
    if (loginuser) {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults)
        {
            NSData *jsonData = [ObjectUtil getJSON:loginuser options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [standardUserDefaults setObject:str forKey:KEY_LOGIN_MEMBER_INFO];
            [standardUserDefaults synchronize];
        }
    }
}

- (LoginUserModel *) getLoginUserInfo{
    NSDictionary *dic =  [[NSUserDefaults standardUserDefaults] dictionaryForKey:KEY_LOGIN_MEMBER_INFO];
    LoginUserModel *loginuser  = [[LoginUserModel alloc] initWithDic:dic];
    return loginuser;
}

#pragma mark  获取登录用户地区信息
- (void) saveLoginLocalModel:(LocalModel *)localModel{
    if (localModel) {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults)
        {
            NSData *jsonData = [ObjectUtil getJSON:localModel options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [standardUserDefaults setObject:str forKey:KEY_LOGIN_LOCAL_INFO];
            [standardUserDefaults synchronize];
        }
    }
}

- (LocalModel *) getLoginLocalModel{
    NSDictionary *dic =  [[NSUserDefaults standardUserDefaults] dictionaryForKey:KEY_LOGIN_LOCAL_INFO];
    LocalModel *loginuser  = [[LocalModel alloc] initWithDic:dic];
    return loginuser;
}


-(NSString*) getThreePartyMD5:(NSDictionary*) dic
{
    NSString *result = [NSString stringWithFormat:@"%@%@%@%@", dic[@"guest_key"], dic[@"open_id"], dic[@"platform_type"], dic[@"device_id"]];
    result = [result toMd5];
    result = [NSString stringWithFormat:@"㵘淼沝水%@", result];
    result = [result toMd5];
    
    return  result;
}

@end
