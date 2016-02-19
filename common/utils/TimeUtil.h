//
//  TimeUtil.h
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject

+(TimeUtil *) sharedInstance;

//延迟执行
+ (void)delayCall:(float)sec block:(VoidBlock)block;
//循环调用
+(dispatch_source_t)interval:(NSTimeInterval)sec block:(VoidBlock)block;
//关闭
+(void) cancleTimer:(dispatch_source_t)t;

//根据时间戳获取年月日时分秒等信息
+(NSDateComponents*) getDateInfoByTimestamp:(double) timestamp;
/**
 *  按指定格式将时间戳转成时间
 *
 *  @param timestamp 时间戳
 *  @param format    格式
 *
 *  @return 时间文本
 */
+ (NSString*)getTimestrWithTimestamp:(NSString*)timestamp format:(NSString *)format;

/**
 *  按指定格式将时间文本转成时间戳
 *
 *  @param timestamp 时间戳
 *  @param format    格式
 *
 *  @return 时间戳
 */
+ (NSString*)getTimestamptrWithTimes:(NSString*)times format:(NSString *)format;
/**
 *  按指定格式将时间转成时间文本
 *
 *  @param date   时间
 *  @param format 格式
 *
 *  @return 时间文本
 */
+ (NSString*)getTimestrWithDate:(NSDate*)date format:(NSString *)format;

/**
 *  通过时间戳 得到一个日期时间  本app很多地方都适用
 *
 *  如果是今天就返回 时间  HH:mm
 *  否则返回 日期和时间    MM-dd HH:mm
 *
 *  @param timestamp 时间戳
 *
 *  @return 返回日期时间
 */
+(NSString*)getMyDateTimestamp:(NSString*)timestamp;


// 返回 刚刚，3分钟前，4小时前类型的时间显示
+ (NSString*)getDateStr1ByTimestamp:(NSString*)timeStr;

@end
