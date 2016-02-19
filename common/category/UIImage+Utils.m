//
//  UIImage+Utils.m
//  lovelive
//
//  Created by Circle on 15/11/28.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


- (UIImage *)reSizeto:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


//等比率缩放
- (UIImage *)toScale:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 *  @author ZMB, 15-11-30 11:11:33
 *
 *  返回带有缩略图的图片数组
 *
 *  @param scaleSize 缩放比例
 *
 *  @return <#return value description#>
 */
- (NSArray *)getArrayWithScaleSize:(float)scaleSize{
    //图片文件
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    NSData *smallImageData = UIImageJPEGRepresentation([self toScale:scaleSize], 1);
    //imageData = smallImageData;
    return [NSArray arrayWithObjects:imageData, smallImageData, nil];
}
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextFillRect(currentContext, fillRect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return smallImage;
}

+(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/**
 *  改变图片颜色
 *
 *  @param tintColor 颜色
 *
 *  @return 改变颜色后的图片
 */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

/**
 *  拉伸图片
 *
 *  @param width  拉伸宽的位置 0.5为中间
 *  @param height 拉伸高的位置 0.5为中间
 *
 *  @return 返回图片
 */
- (UIImage *) stretchableWidth:(CGFloat)width Height:(CGFloat)height
{
    return [self stretchableImageWithLeftCapWidth:(self.size.width*width) topCapHeight:(self.size.height*height)];
}

- (UIImage *)imageWithGaussianBlur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    NSData *imgData = UIImagePNGRepresentation(self);
    CIImage *image = [CIImage imageWithData:imgData];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@2.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[image extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}
@end
