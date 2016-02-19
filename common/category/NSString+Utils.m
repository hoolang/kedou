//
//  NSString+Utils.m
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Utils)
/**
 *  md5加密
 *
 *  @return 加密后的字符串
 */
-(NSString *)toMd5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
/**
 *  加密规则
 *
 *  @return 字符串
 */
- (NSString *)secretRole{
    return [[self toMd5] toMd5];
}

/**
 *  是否位手机号
 *
 *  @return true or false
 */
-(BOOL)isMoblePhone{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
   return [pred evaluateWithObject:self];
}

+ (NSArray *)getFileNamesWithLoginID:(NSString *)loginID{
    
    NSDateComponents *dateComponent = [NSDate currentDate];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    //时间戳
    NSString *timeString = [NSDate timeStamp];
    
    NSString *filename = [NSString stringWithFormat:@"%ld/%ld/%ld/%@-%@.jpg", year, month, day, loginID, timeString];
    NSString *filename2 = [NSString stringWithFormat:@"%ld/%ld/%ld/%@-%@-s.jpg", year, month, day, loginID, timeString];
    
    return [NSArray arrayWithObjects:filename, filename2, nil];
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 获得系统版本
    if (iOS7) {
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    } else {
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

+(BOOL)isHttp:(NSString*)http
{
    if ([http rangeOfString:@"http"].location == 0) {
        return true;
    }
    return false;
}

//根据日期来计算年龄
+ (NSString*)fromDateToAge:(NSDate*)date
{
    
    if (date == nil) {
        return nil;
    }
    NSDate *myDate = date;
    
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:myDate toDate:nowDate options:0];
    
    int year = [comps year];
    
    return [NSString stringWithFormat:@"%d",year];
    
}

- (NSString *)dateCompareNow
{
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [self dateCompareNow:(NSString *) dateFormat];
}

- (NSString *)dateCompareNow:(NSString *) dateFormat
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    // fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // _created_at = @"Tue Sep 30 17:06:25 +0600 2014";
    fmt.dateFormat = dateFormat;
    
    // 创建日期
    NSDate *createDate = [fmt dateFromString:self];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { // 今年
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

/**
 *  去前后空格
 *
 *  @return 返回新字符串
 */
-(NSString *)Trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)getThumbnailImageURL
{
    return [self getThumbnailImageURL:@"-s"];
}

// 目前只适配URL只有一个 点 的文件名 如：  123456789.jpg
- (NSString *)getThumbnailImageURL:(NSString *)suffix
{
    NSString *tmp = [NSString stringWithFormat:@"%@", self];
    NSArray *arr = [tmp componentsSeparatedByString:@"."];
    //LLLog(@"arr.count %ld", arr.count);
    if(arr.count == 2){
        //LLLog(@"%@", [NSString stringWithFormat:@"%@%@.%@",arr[0], suffix, arr[1]]);
        return [NSString stringWithFormat:@"%@%@.%@",arr[0], suffix, arr[1]];
    }
    return self;
}

/**
 *  获取图片的mp4 如:123.jpg 得到123.mp4
 *
 *  @return .mp4
 */
- (NSString *)getMp4URL
{
    
    NSString *tmp = [NSString stringWithFormat:@"%@", self];
    NSArray *arr = [tmp componentsSeparatedByString:@"."];
    if(arr.count == 2){
        return [NSString stringWithFormat:@"%@.mp4",arr[0]];
    }
    return self;
}
@end
