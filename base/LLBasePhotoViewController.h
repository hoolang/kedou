//
//  LLBasePhotoViewController.h
//  lovelive
//
//  Created by hmn on 16/1/18.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//
// 可以调用 相机 或 相册 的父类
// 因为很多地方都用到了
// 用到的请继承本类
#import "BaseViewController.h"

@interface LLBasePhotoViewController : BaseViewController
/**
 *  是否需要裁剪 默认是
 */
@property(nonatomic,assign)BOOL allowsEditing;

/**
 *  请选择相机 或 相册
 */
-(void)initPhoto;

/**
 *  启动相机
 */
-(void)photoCamera;
/**
 *  启动相册
 */
-(void)photoAlbumr;

/**
 *  回调图片 之类需要实现这个方法
 *
 *  @param image 图片
 */
-(void)backImage:(UIImage *)image;
@end
