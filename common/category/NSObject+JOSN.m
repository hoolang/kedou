//
//  NSObject+JOSN.m
//  lovelive
//
//  Created by hmn on 16/1/14.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "NSObject+JOSN.h"

@implementation NSObject (JOSN)
/**
 *  NSJSON 转 NSString 一般用于字典或数组转字符串 其它未测
 *
 *  @return 返回NSString
 */
-(NSString *)jsonToString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}
@end

@implementation NSString (JOSN)
/**
 *  NSString 转 NSJSON 一般用于字符串转字典或数组 其它未测
 *
 *  @return 返回id
 */
-(id)stringToJson
{
    NSData* xmlData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:xmlData options:kNilOptions error:nil];
}
@end