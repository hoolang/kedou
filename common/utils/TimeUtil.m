//
//  TimeUtil.m
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import "TimeUtil.h"

@interface TimeUtil(){
}

@end

@implementation TimeUtil

+(TimeUtil *)sharedInstance{
    static TimeUtil *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TimeUtil alloc] init];
    });
    return instance;
}

//延迟调用
+(void)delayCall:(float)sec block:(VoidBlock)block{
    dispatch_queue_t curQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec ),
                   curQueue, ^(void){
                       dispatch_async(dispatch_get_main_queue(), ^{
                           block();
                       });
                       
                   } );
}

//循环调用
+(dispatch_source_t)interval:(NSTimeInterval)sec block:(VoidBlock)block{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
    dispatch_resume(_timer);
    return _timer;
}

//关闭
+(void) cancleTimer:(dispatch_source_t)t{
    dispatch_source_cancel(t);
}

//根据时间戳获取年月日时分秒等信息
+(NSDateComponents*) getDateInfoByTimestamp:(double) timestamp {
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timestamp/1000];
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    
    return dateComponents;
}


+ (NSString*)getTimestrWithTimestamp:(NSString*)timestamp format:(NSString *)format {
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:format];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timestamp doubleValue]/1000)];
    return [self getTimestrWithDate:date format:format];
}
/**
  *  按指定格式将时间戳转成时间
  *
  *  @param timestamp 时间戳
  *  @param format    格式
  *
  *  @return 时间文本
  */
+ (NSString*)getTimestamptrWithTimes:(NSString*)times format:(NSString *)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate* inputDate = [formatter dateFromString:times];
    NSTimeInterval time=[inputDate timeIntervalSince1970];
    NSString *timeSp = [NSString stringWithFormat:@"%0.f000", time];
    return timeSp;
    
}
/**
 *  按指定格式将时间转成时间文本
 *
 *  @param date   时间
 *  @param format 格式
 *
 *  @return 时间文本
 */
+ (NSString*)getTimestrWithDate:(NSDate*)date format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}
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
+(NSString*)getMyDateTimestamp:(NSString*)timestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[LoginMgr sharedInstance] getServerTime]];
    NSString *today=[TimeUtil getTimestrWithDate:date format:@"yyyyMMdd"];
    NSString *courseday=[TimeUtil getTimestrWithTimestamp:timestamp format:@"yyyyMMdd"];
    NSString *myDate=@"";
    if([today isEqualToString:courseday])
        myDate=[TimeUtil getTimestrWithTimestamp:timestamp format:@"HH:mm"];
    else
        myDate=[TimeUtil getTimestrWithTimestamp:timestamp format:@"MM-dd HH:mm"];
    
    return myDate;
}

// 返回 刚刚，3分钟前，4小时前类型的时间显示
+ (NSString*)getDateStr1ByTimestamp:(NSString*)timeStr
{
    NSTimeInterval timeInter = [timeStr doubleValue]/1000;
//    NSTimeInterval nowInter = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval nowInter =[[LoginMgr sharedInstance] getServerTime];

    double betweenTime = nowInter - timeInter;
    double min = 60;
    double hour = min * 60;
    double timeMin = floor(betweenTime / min);
    double timeHour = floor(betweenTime / hour);
    NSString *outStr = @"";
    if (timeMin <= 3) {
        outStr = LLLangCzh(@"just");
    } else if (timeMin < 60) {
        outStr = [NSString stringWithFormat:LLLangCzh(@"%.0f minutes ago"), timeMin];
    } else if (timeHour <= 5) {
        outStr = [NSString stringWithFormat:LLLangCzh(@"%.0f hours ago"), timeHour];
    } else {
        outStr = [TimeUtil getMyDateTimestamp:timeStr];
    }
    return outStr;
//    NSLog(@"----------* %@", [TimeUtil getTimestrWithTimestamp:timeStr format:@"yyyy-MM-dd HH:MM:SS"]);
//    NSLog(@"----------* %@", [TimeUtil getTimestrWithDate:[NSDate new] format:@"yyyy-MM-dd HH:MM:SS"]);
//    NSLog(@"----------* create_time %f, nowInter %f, s %f, min %f, hour %f", timeInter,nowInter,betweenTime, timeMin, timeHour);

}
@end
