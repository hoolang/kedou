//
//  NSString+Utils.h
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)
/*
 * 字符串进行MD5加密
 */
- (NSString *)toMd5;
/**
 *  加密规则
 *
 *  @return 字符串
 */
- (NSString *)secretRole;
/*
 * 是否位手机
 */
- (BOOL)isMoblePhone;
/**
 *  @author ZMB, 15-11-30 12:11:39
 *
 *  传入登录id生产一个文件名数组
 *
 *  @param loginID 登录id
 *
 *  @return 返回一个带有两个文件名的数组
 */
+ (NSArray *)getFileNamesWithLoginID:(NSString *)loginID;
/**
 *  @author ZMB, 15-12-04 11:12:32
 *
 *  计算文本的尺寸
 *
 *  @param font 文本字体
 *  @param maxW 最大宽度
 *
 *  @return 返回文本的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/**
 *  @author ZMB, 15-12-04 11:12:51
 *
 *  计算文本的尺寸
 *
 *  @param font 字体
 *
 *  @return 返回文本的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font;
/*
 * 是否http开头
 */
+(BOOL)isHttp:(NSString*)http;
/**
 *  @author ZMB, 15-12-06 19:12:26
 *
 *  根据时间发回年龄
 *
 *  @param date NSDate类型的时间
 *
 *  @return 年龄字符串
 */
+ (NSString*)fromDateToAge:(NSDate*)date;
- (NSString *)dateCompareNow;
- (NSString *)dateCompareNow:(NSString *) dateFormat;
/**
 *  去前后空格
 *
 *  @return 返回新字符串
 */
-(NSString *)Trim;
/**
 *  获取缩略图地址
 *
 *  @return 缩略图地址
 */
- (NSString *)getThumbnailImageURL;
/**
 *  获取图片的mp4 如:123.jpg 得到123.mp4
 *
 *  @return .mp4
 */
- (NSString *)getMp4URL;
@end
