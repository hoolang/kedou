//
//  LogUtil.h
//  lovelive
//
//  Created by Kong on 15/11/24.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogUtil : NSObject

//debug日志
+ (void)d:(NSString *)str;
//错误
+ (void)e:(NSString *)str;

@end
