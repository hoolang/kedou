//
//  NSDate+Utils.h
//  lovelive
//
//  Created by Circle on 15/11/30.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)
/**
 *  获取当前时间戳
 *
 *  @return 字符串类型的时间戳
 */
+ (NSString *)timeStamp;
/**
 *  获取服务器当前时间
 *
 *  @return 服务器时间
 */
+ (NSString *)timeStampMsec;
/**
 *  获取当前时间
 *
 *  @return 返回NSDateComponents， 通过[currentDate year]获取年，[currentDate month]获取月份...
 */
+ (NSDateComponents *)currentDate;
/**
 *  @author ZMB, 15-12-06 19:12:49
 *
 *  字符串转时间
 *
 *  @param date      传入的时间
 *  @param formatter 传入的时间格式  @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 发回date类型的时间
 */
+ (NSDate *)stringToDate:(NSString *)date formatter:(NSString *)formatter;
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
@end
