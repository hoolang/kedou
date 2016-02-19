//
//  BaseViewController.h
//  lovelive
//
//  Created by Kong on 15/11/24.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface BaseViewController : UIViewController{
    MBProgressHUD* _tipsView;
    MBProgressHUD* _textHUD;
    BOOL _initViewForLang;
    MBProgressHUD *_loading;
    UIImageView *navBackgroudView;
}

//显示提示文本 默认时间2秒 hmn
-(void)showTextHud:(NSString *)msg;
//显示提示文本 带时间
-(void)showTextHud:(NSString *)msg delay:(int)delay;
-(void)showAlert:(NSString*)msg;
/**
 *  显示等待菊花
 */
-(void)showLoading;
/**
 *  关闭等待菊花
 */
-(void)hideLoading;

//显示自定义提示框 ui
-(void)showLLAlert:(NSString*)msg;
-(void)showTips:(NSString*)msg;
-(void)hideTips;
-(void)hideTips:(NSString*)msg afterDelay:(NSTimeInterval)delay;

//跳到下一页 返回时判断是否需要TabBar
-(void)pushViewController:(UIViewController*)cont animated:(BOOL)animated;
//返回到本页是否需要TabBar，子类要显示TabBar时需要重写这个方法
-(BOOL)needTabBar;
//是否显示titleBar 子类要隐藏时可以重写这个方法
-(BOOL)needTitleBar;
//是否显示电量状态栏 子类可以重新此方法来实现需不需要状态栏
-(BOOL)needStatusBar;
//是否设置titleBar为不透明，子类可以重新此方法来实现需不需要状态栏透明
-(BOOL)needTitleBarOpacity;
//是否可以设置titleBar的透明
-(BOOL)needChangeTitleBarOpacity;
//根据titlebar和statusbar决定导航栏是否显示以及其颜色
-(void)setTitleBarHidden:(BOOL)isHidden needStatusBarHidden:(BOOL)statusBarHidden;
//视图顶部 距离
@property (nonatomic,assign,readonly) CGFloat viewTop;
/**
 *  创建一个按钮 很多地方都通用 黄色的 全国通用
 *
 *  @param title 按钮标题
 *
 *  @return 返回一个按钮
 */
- (UIButton*)createButtonWithTitle:(NSString *)title;
/**
 *  创建一个标签 很多地方都通用 5a5a5a 全国通用
 *
 *  @param text 标签文本
 *  @param font 字体大小
 *
 *  @return 返回标签
 */
- (UILabel*)createLableWithText:(NSString *)text font:(int)font;
-(CGFloat)tabBarHeight;

#pragma mark 多语言更新界面
// 子类重写该方法
-(void) updateViewForLanguage;

@end
