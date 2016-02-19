//
//  NotificationUtil.h
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationUtil : NSObject


+(void)registerNotification:(id)observer selector:(SEL)aSelector name:(NSString *)aName;

+(void)postNotification:(NSString *)aName object:(id)obj userinfo:(NSDictionary *)userinfo;

@end
