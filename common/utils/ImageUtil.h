//
//  ImageUtil.h
//  lovelive
//
//  Created by Kong on 15/12/1.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtil : NSObject

+(ImageUtil *) sharedInstance;

// 用颜色生成图片
-(UIImage *)createImageWithColor:(UIColor*)color;

/*
 * 颜色转为图片
 */
+ (UIImage *) getImageWithColorStr: (NSString *) colorStr;


/*
 * 颜色转换
 */
+ (UIColor *) colorWithStr: (NSString *)color;

/*
 * 添加上服务器的前缀
 */
+ (NSString *) getFullPath: (NSString *) postfixPath;
/**
 *  @author ZMB, 15-12-22 15:12:00
 *
 *  显示大图
 *
 *  @param avatarImageView 需要放大的图片
 */
+(void)showImage:(UIImageView*)avatarImageView;
/**
 *  通过uiview生成图片
 *
 *  @param view 要生成图片的view
 *
 *  @return 返回图片
 */
+(UIImage*)createImageFromView:(UIView*)view;

//取随机颜色
+(UIColor *)getRadomColor;
@end
