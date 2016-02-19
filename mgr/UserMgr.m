//
//  UserMgr.m
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import "UserMgr.h"
#import "UserModel.h"
#import "sys/utsname.h"
#import "sys/sysctl.h"




#define USER_INFO_CACHE_TIME 60*60*24

@implementation UserMgr

@synthesize userInfoDic;

+(UserMgr *)sharedInstance{
    static UserMgr *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserMgr alloc] init];
        [instance initialize];
    });
    return instance;
}

-(void) initialize{
    userInfoDic = [[NSMutableDictionary alloc]init];
}
-(UserModel *)userModel
{
    return [self getUserInfoById:LOGIN_UID];
}


// 添加用户信息到内存
-(void)addUserWithDic:(NSDictionary *)dic{
    if (!userInfoDic) {
        userInfoDic = [[NSMutableDictionary alloc] init];
    }
    UserModel *userModel = [[UserModel alloc] initWithDic:dic];
    [userInfoDic setValue:userModel forKey:[NSString stringWithFormat:@"%@",userModel.uid]];
    
    // hmn
    //通过uid保存用户信息
    NSMutableDictionary *dic1=[NSMutableDictionary dictionaryWithDictionary:dic];
    //加个时间
    dic1[@"nowTime"]=[NSDate timeStamp];
    NSString *userInfo=[dic1 jsonToString];
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:USER_INFO_WITH_UID(userModel.uid)];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

// 对于拉下来的一些uid列表，检查需要更新数据的用户,返回ids字符串,如 "100002,100003,"
- (NSString*) formatUIDStrings:(NSDictionary*) serviceData uidKey:(NSString*) key {
    NSString *resultStr = @"";
    NSString *uidKey = @"uid";
    
    if (! [key isEqual:@""]) {
        uidKey = key;
    }
    
    for(NSDictionary *dic in serviceData) {
        NSString *uidValue = [NSString stringWithFormat:@"%@", dic[uidKey]];
        
        if ([self checkUserIsNeedRefreshById:uidValue]) {
            if ([resultStr rangeOfString:uidValue].location == NSNotFound) {
                resultStr = [NSString stringWithFormat:@"%@%@,", resultStr, uidValue];
            }
        }
    }
    
    return resultStr;
}

// 检查指定id的用户是否需要更新数据
- (BOOL) checkUserIsNeedRefreshById: (NSString*) uidValue {
    BOOL isNeedUpdate = true;
    
    if (uidValue== nil || [uidValue isEqual:@""]) {
        isNeedUpdate = false;
    } else {
        UserModel* userInfo = [self getUserInfoById:uidValue];
        if (userInfo!= nil) {
            isNeedUpdate = [userInfo isNeedUpdate];
        }
    }
    
    return isNeedUpdate;
}
/**
 *  更新本地缓存  关注状态
 *
 *  @param uid    用户id
 *  @param follow 关注状态
 */
-(void)updataUserInfoWithUid:(NSString*)uid follow:(int)follow
{
    
    NSString *userInfo=[[NSUserDefaults standardUserDefaults] stringForKey:USER_INFO_WITH_UID(uid)];
    if(userInfo)
    {
        id josn=[userInfo stringToJson];
        UserModel *userModel = [[UserModel alloc] initWithDic:josn];
        userModel.notice_status=follow;
        NSDictionary *dic1=[userModel getAttr];
        NSString *userInfo=[dic1 jsonToString];
        [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:USER_INFO_WITH_UID(userModel.uid)];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
- (UserModel*) getUserInfoById:(NSString*) uidValue {
    /**
     *  添加取缓存  by  hmn
     */
    NSString *uid = [NSString stringWithFormat:@"%@",uidValue];
    //取内存
    UserModel *userModel = userInfoDic[uid];
    if (!userModel)
    {
        //没内存 取本地
        NSString *userInfo=[[NSUserDefaults standardUserDefaults] stringForKey:USER_INFO_WITH_UID(uid)];
        if(userInfo)
        {
            id josn=[userInfo stringToJson];
            //加时间判断
            CGFloat time=[[NSDate timeStamp]doubleValue] -[josn[@"nowTime"] doubleValue];
            //30分钟
            if (time<USER_INFO_CACHE_TIME) {
                userModel = [[UserModel alloc] initWithDic:josn];
                userModel.updateTime=[josn[@"nowTime"] doubleValue];
                //保存到内存
                [userInfoDic setValue:userModel forKey:uid];
            }
        }
    }
    return userModel;
    
//    return userInfoDic[uidValue];
}


- (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //CLog(@"%@",deviceString);
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //CLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
}

@end
