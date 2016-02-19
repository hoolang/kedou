//
//  UIImage+Utils.h
//  lovelive
//
//  Created by Circle on 15/11/28.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
- (UIImage *)reSizeto:(CGSize)reSize;

/**
 *  @author ZMB, 15-11-30 11:11:12
 *
 *  生产带有缩略图的数组
 *
 *  @param scaleSize 缩放尺寸
 *
 *  @return 返回带有原图和一个缩略图的数组
 */
- (UIImage *)toScale:(float)scaleSize;
/**
 *  返回一个含有两个UIImage的数组
 *
 *  @param reSize 小图的尺寸
 *
 *  @return 返回一个含有两个UIImage的数组
 */
- (NSArray *)getArrayWithScaleSize:(float)scaleSize;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
/**
 *  裁剪图片
 *
 *  @param rect 保留的范围
 *
 *  @return 裁剪后的图片
 */
- (UIImage*)getSubImage:(CGRect)rect;
/**
 *  @author ZMB, 15-12-20 15:12:04
 *
 *  根据颜色创建一个图片
 *
 *  @param color UICOlor
 *
 *  @return 根据颜色创建的图片
 */
+(UIImage *) createImageWithColor: (UIColor *) color;
/**
 *  改变图片颜色
 *
 *  @param tintColor 颜色
 *
 *  @return 改变颜色后的图片
 */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
/**
 *  拉伸图片
 *
 *  @param width  拉伸宽的位置 0.5为中间
 *  @param height 拉伸高的位置 0.5为中间
 *
 *  @return 返回图片
 */
- (UIImage *) stretchableWidth:(CGFloat)width Height:(CGFloat)height;
/**
 * 高斯模糊
 *
 * @return 返回高斯模糊后的照片图片
 */
- (UIImage *)imageWithGaussianBlur;
@end
