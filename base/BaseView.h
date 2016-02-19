//
//  BaseView.h
//  lovelive
//
//  Created by Kong on 15/11/24.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView


#pragma mark 多语言更新界面
// 子类重写该方法
-(void) updateViewForLanguage;

@end
