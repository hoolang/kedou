//
//  BaseViewController.m
//  lovelive
//
//  Created by Kong on 15/11/24.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseViewController.h"
#import "LLCustomAlertView.h"

@interface BaseViewController ()
{
    bool isNeedbringSubviewToFront;
}

@end

@implementation BaseViewController

-(void)dealloc{
    LLLog(@"BaseViewConroller Dealloc ...... %@ ", NSStringFromClass([self class]) );
//    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:LANGUAGE_UPDATE];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //所有有背景色的界面，色值都是：f2f2f2
    self.view.backgroundColor=LLColor(0xf2, 0xf2, 0xf2);
    
    _tipsView=[[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    _tipsView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tipsView];
    
    UINavigationBar *navigationBar=self.navigationController.navigationBar;
    //标题颜色
    navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:19],NSFontAttributeName,nil];
    //左右标题的颜色
    navigationBar.tintColor=[UIColor whiteColor];
    //去掉UINavigationBar底部的细线
    navigationBar.shadowImage=[[UIImage alloc] init];
    //导航条设置为不透明
    navigationBar.translucent=NO;
    //全屏 View不会下移64
    self.extendedLayoutIncludesOpaqueBars = YES;
    //状态栏及Nav颜色
    UIImage *background=[[UIImage imageNamed:@"background2"] stretchableWidth:0.5 Height:0.1];
    [navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setTranslucent:YES];
    //返回 不需要文字
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    UIImage *image = [UIImage imageNamed:@"return"];
    image = [image stretchableImageWithLeftCapWidth:(image.size.width-0.1) topCapHeight:0.1];
    [backItem setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = backItem;
    
    UIView* navTmp= [self.navigationController.navigationBar valueForKey:@"_backgroundView"];
    CGRect frame = CGRectMake(0, 0, SCREEN_W, 64);
    navBackgroudView = [[UIImageView alloc] initWithImage:background];
    navBackgroudView.frame = frame;
    
    if (navTmp) {
        [self.view insertSubview:navBackgroudView aboveSubview:navTmp];
        isNeedbringSubviewToFront = NO;
    }
    else{
        [self.view insertSubview:navBackgroudView atIndex:0];
        isNeedbringSubviewToFront = YES;
    }
    
    // 监听语言更新，更新界面
    [NotificationUtil registerNotification:self selector:@selector(updateViewForLanguage) name:LANGUAGE_UPDATE];
    _initViewForLang = NO;
}

-(void) viewWillAppear:(BOOL)animated{
    LLLogFunc
    [super viewWillAppear:animated];
    if ([self needTitleBar]) {
        [self.navigationController.navigationBar setHidden:NO];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTranslucent:YES];
        [navBackgroudView setAlpha:1];
        if (isNeedbringSubviewToFront) {
            [self.view bringSubviewToFront:navBackgroudView];
            isNeedbringSubviewToFront = NO;
        }
    }else{
        [self.navigationController.navigationBar setHidden:YES];
        [navBackgroudView setAlpha:0];
    }
    
    if ([self needStatusBar]) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        navBackgroudView.height = 64;
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        navBackgroudView.height = 44;
    }
    
    if (_initViewForLang == NO) {
        [self updateViewForLanguage];
        _initViewForLang = YES;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController*)cont animated:(BOOL)animated {
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:cont animated:animated];
    if([self needTabBar])
        [self setHidesBottomBarWhenPushed:NO];
    
    if ([self needTitleBar]) {
        [self.navigationController.navigationBar setHidden:NO];
    }else{
        [self.navigationController.navigationBar setHidden:YES];
    }

}

-(void)setTitleBarHidden:(BOOL)isHidden needStatusBarHidden:(BOOL)statusBarHidden{
    if (isHidden) {
        [self.navigationController.navigationBar setHidden:YES];
        [navBackgroudView setAlpha:0];
    }else{
        [self.navigationController.navigationBar setHidden:NO];
        [navBackgroudView setAlpha:1];
        [self.view bringSubviewToFront:navBackgroudView];
        if (!statusBarHidden) {
            navBackgroudView.height = 64;
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
        else
        {
            navBackgroudView.height = 44;
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
        }
    }
}

-(BOOL)needTabBar {
    return NO;
}

-(BOOL)needTitleBar{
    return YES;
}

-(BOOL)needStatusBar{
    return YES;
}

-(BOOL)needTitleBarOpacity
{
    return YES;
}

-(BOOL)needChangeTitleBarOpacity
{
    return YES;
}

-(BOOL)isPush
{
    return NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
//显示提示文本 默认时间2秒 hmn
-(void)showTextHud:(NSString *)msg
{
    [self showTextHud:msg delay:2];
}
//显示提示文本 带时间
-(void)showTextHud:(NSString *)msg delay:(int)delay
{
    //放在键盘之上
    NSInteger windIndex = 0;
    if ([[UIApplication sharedApplication].windows count]>1)
    {
        windIndex = 1;
    }
    else
    {
        windIndex = 0;
    }
    UIWindow *win=[[UIApplication sharedApplication].windows objectAtIndex:windIndex];
    
    MBProgressHUD *textHUD = [MBProgressHUD showHUDAddedTo:win animated:YES];//显示到最顶层 确保每个页面都显示
    [textHUD setMode:MBProgressHUDModeText];
    [textHUD setLabelText:msg];
    [textHUD setMargin:10.f];
    [textHUD setUserInteractionEnabled:NO];
    [textHUD hide:YES afterDelay:delay];
}
-(void)showAlert:(NSString*)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
/**
 *  显示等待菊花
 */
-(void)showLoading
{
    _loading = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];//显示到最顶层 确保每个页面都显示
}
/**
 *  关闭等待菊花
 */
-(void)hideLoading
{
    if (_loading) {
        [_loading hide:YES];
    }
}
//显示自定义提示框 ui
-(void)showLLAlert:(NSString*)msg {
    LLCustomAlertView *alert=[[LLCustomAlertView alloc]initWithTitle:nil message:msg delegate:nil doneButtonTitle:@"确定" cancelButtonTitle:nil type:LLCustomAlertViewFail];
    [alert show];
}

-(void)showTips:(NSString*)msg{
    [self.view bringSubviewToFront:_tipsView];
    _tipsView.labelText=msg;
    [_tipsView show:YES];
}
-(void)hideTips{
    [_tipsView hide:NO];
}
-(void)hideTips:(NSString*)msg afterDelay:(NSTimeInterval)delay{
    _tipsView.labelText=msg;
    [_tipsView hide:YES afterDelay:0.3];
}

-(CGFloat)viewTop
{
    if (self.navigationController) {
        return self.navigationController.navigationBar.height+20;
    }
    return 0;
}
//tabBar高度
-(CGFloat)tabBarHeight
{
    if (self.tabBarController) {
        return self.tabBarController.tabBar.height;
    }
    return 0;
}
/**
 *  创建一个按钮 很多地方都通用 黄色的 全国通用
 *
 *  @param title 按钮标题
 *
 *  @return 返回一个按钮
 */
- (UIButton*)createButtonWithTitle:(NSString *)title
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(15, 0, self.view.width-30, 35);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn setBackgroundImage:[UIImage createImageWithColor:LLColor(0xf2, 0xad, 0x2e)] forState:UIControlStateNormal];
    btn.layer.cornerRadius=3;
    btn.clipsToBounds = YES;
    return btn;
}
/**
 *  创建一个标签 很多地方都通用 5a5a5a 全国通用
 *
 *  @param text 标签文本
 *  @param font 字体大小
 *
 *  @return 返回标签
 */

- (UILabel*)createLableWithText:(NSString *)text font:(int)font
{
    UILabel *lab=[[UILabel alloc]init];
    lab.textColor=LLColor(0x5a, 0x5a, 0x5a);
    lab.frame=self.view.bounds;
    lab.font=[UIFont systemFontOfSize:font];
    lab.text=text;
    [lab sizeToFit];
    return lab;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark 多语言更新界面
-(void) updateViewForLanguage
{
    LLLogFunc
}

@end
