//
//  NSObject+JOSN.h
//  lovelive
//
//  Created by 91wan on 16/1/14.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JOSN)
/**
 *  NSJSON 转 NSString 一般用于字典或数组转字符串 其它未测
 *
 *  @return 返回NSString
 */
-(NSString *)jsonToString;
@end
@interface NSString (JOSN)
/**
 *  NSString 转 NSJSON 一般用于字符串转字典或数组 其它未测
 *
 *  @return 返回id
 */
-(id)stringToJson;
@end
