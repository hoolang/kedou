//
//  ConstantUtil.h
//  lovelive
//
//  Created by TerryChao on 15/12/10.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//  处理常量

#import <Foundation/Foundation.h>

@interface ConstantUtil : NSObject

// 字符串0,1 转换成YES,ON
+(BOOL) getCommonStausByString:(NSString*) valueStaus;
// YES,ON 转换成0,1
+(NSString*) getCommonStatusString:(BOOL) status;

// 0,1 转换成YES,ON
+(BOOL) getCommonStausByInt:(int) valueStaus;

@end
