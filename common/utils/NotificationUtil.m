//
//  NotificationUtil.m
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import "NotificationUtil.h"

@implementation NotificationUtil


+(void)registerNotification:(id)observer selector:(SEL)aSelector name:(NSString *)aName{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:nil];
}

+(void)postNotification:(NSString *)aName object:(id)obj userinfo:(NSDictionary *)userinfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:obj userInfo:userinfo] ;
}

@end
