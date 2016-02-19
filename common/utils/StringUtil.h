//
//  StringUtil.h
//  lovelive
//
//  Created by Kong on 15/11/24.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

/*
    颜色转换
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

/**
 * 生成随机字符串
 */
+ (NSString *)getRandString:(int)lenght;

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForTextView:(UITextView *)textView andWidth:(float)width;

/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+(float) heightForString:(NSString *)value andWidth:(float)width;
/**
 *  分转元
 *
 *  @param fen分
 *
 *  @return 返回元
 */
+(NSString *)getYuanWithFen:(NSString *)fen;
/**
 *  元转分
 *
 *  @param yuan 元
 *
 *  @return 返回分
 */
+(NSString *)getFenWithYuan:(NSString *)yuan;
@end
