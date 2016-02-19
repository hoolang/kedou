//
//  DeviceMgr.m
//  lovelive
//
//  Created by Kong on 15/12/28.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "DeviceMgr.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#define lovelive_device_id_keychain_identifier @"lovelive_device_id_keychain_identifier"

@implementation DeviceMgr

+(DeviceMgr *)sharedInstance{
    static DeviceMgr *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DeviceMgr alloc] init];
    });
    return instance;
}

-(void)dealloc{
    if (_timerReport) {
        [_timerReport invalidate];
        _timerReport = nil;
    }
}

-(id)init{
    self = [super init];
    if (self) {
        [self checkDeviceID];
    }
    return self;
}

-(void)checkDeviceID{
//    NSString *str = [self getDeviceIDKeychainString];
//    if (str && ![str isEqual:@""]) {
//        return;
//    }
//    [self reportDeviceSucc:^(id data){
//       // [self setDeviceIDKeychainValue:data];
//    }];
}

////设置MoyiDeviceID值
//- (void) setDeviceIDKeychainValue:(id)value{
//    KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:lovelive_device_id_keychain_identifier accessGroup:nil];
//    [keychain setObject:value forKey:(id)kSecValueData];
//}
//
////取MoyiDeviceID值
//- (NSString *) getDeviceIDKeychainString{
//    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:lovelive_device_id_keychain_identifier accessGroup:nil];
//    NSString *str =[keychain objectForKey:(id)kSecValueData];
//    return str;
//}
//
//-(void)reportDeviceSucc:(CompletionBlock)succ{
//    UIDevice *device_=[[UIDevice alloc] init];
//    NSString *deviceID = @"deviceid";
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:deviceID forKey:@"devid"];
//    [params setObject:[NSString stringWithFormat:@"%@-%@",[self getCurrentDeviceModel], device_.name] forKey:@"devicename"];
//    [params setObject:@"ios" forKey:@"deviceos"];
//    [params setObject:device_.systemVersion forKey:@"appversion"];
//    [params setObject:@"1" forKey:@"platform"];
//    [params setObject:[NSBundle mainBundle].bundleIdentifier forKey:@"packageident"];
//    [self queryApiName:@"base/report/device" params:params cacheTime:180 tag:0 completionBlock:^(id data){
//        if (succ) {
//            succ(data);
//        }
//    } faildBlock:^(NSString *str){}];
//}
//
//-(void)reportActiveSucc:(CompletionBlock)succ{
//    if (!iSLOGIN) {
//        return;
//    }
//    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    params[@"login_uid"] = LOGIN_UID;
//    params[@"login_token"] = LOGIN_TOKEN;
//    params[@"devid"] = [[DeviceMgr sharedInstance] getDeviceIDKeychainString];
//    params[@"uid"] = LOGIN_UID;
//    params[@"longitude"] = @"";
//    params[@"latitude"] = @"";
//    params[@"platform"] = @"1";
//    params[@"packageident"] = [appInfo objectForKey:@"CFBundleIdentifier"];
//    params[@"province"] = @"";
//    params[@"city"] = @"";
//    params[@"online_status"] = _isBusy ? @"5" : @"1"; // 1:在线，5：连接中，忙碌
//    [self queryApiName:@"base/report/active" params:params cacheTime:0 tag:0 completionBlock:^(id data){
//        if (succ) {
//            succ(data);
//        }
//    } faildBlock:^(NSString *str){}];
//}

-(void) runTask{
    if (_timerReport) {
        [_timerReport invalidate];
        _timerReport = nil;
    }
    _timerReport = [NSTimer scheduledTimerWithTimeInterval:3 * 60 target:self selector:@selector(reportHandler:) userInfo:nil repeats:YES];
    [self reportHandler:nil];
}

-(void)reportHandler:(NSTimer *)timer{
//    [self reportActiveSucc:^(id data){
//    }];
}


//取设备信息
- (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = (char*)malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

-(void) setIsBusy:(BOOL)busy{
    _isBusy = busy;
}

-(BOOL)getIsBusy{
    return _isBusy;
}


@end
