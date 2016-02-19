//
//  NSDate+Utils.m
//  lovelive
//
//  Created by Circle on 15/11/30.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)
/**
 *  当前时间戳
 *
 *  @return 返回时间戳字符串
 */
+ (NSString *)timeStamp{
    NSTimeInterval interval = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", interval];
}
/**
 *  获取服务器当前时间
 *
 *  @return 服务器时间
 */
+ (NSString *)timeStampMsec
{
    NSTimeInterval interval = [[LoginMgr sharedInstance] getServerTime];
    return [NSString stringWithFormat:@"%.0f000", interval];
}
/**
 *  返回当前时间
 *
 *  @return <#return value description#>
 */
+ (NSDateComponents *)currentDate{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    return [calendar components:unitFlags fromDate:now];
}

+ (NSDate *)stringToDate:(NSString *)date formatter:(NSString *)formatter
{
    if (!formatter) {
        formatter = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:formatter];
    return [inputFormatter dateFromString:date];
}
/**
*  判断某个时间是否为今年
*/
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    // date ==  2016-01-17 10:05:28 --> 2016-01-17 00:00:00
    // now == 2016-01-18 09:22:10 --> 2016-01-18 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    
    
    // 2016-01-17
    NSString *dateStr = [fmt stringFromDate:self];
    // 2016-01-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2016-01-17 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2016-01-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}
@end
