//
//  UserUtil.m
//  lovelive
//
//  Created by Circle on 15/11/30.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "UserUtil.h"
#import "LoginMainViewController.h"
#import "UIImageView+WebCache.h"
#import "MyViewController.h"
#import "LoginViewController.h"

#define SHOW_LOGIN_NOTIFITION @"SHOW_LOGIN_NOTIFITION"


@interface UserUtil()<UIAlertViewDelegate>{
    
}

@end

@implementation UserUtil

+(UserUtil *)sharedInstance{
    static UserUtil *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserUtil alloc] init];
    });
    return instance;
}

-(id)init{
    self =[ super init];
    if (self) {
        [NotificationUtil registerNotification:self selector:@selector(showLogin) name:SHOW_LOGIN_NOTIFITION];
    }
    return self;
}


-(void) alertShowLogin{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[LangUtil langForKey:@"您的账号已经在其他地方登录！"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 1000001;
    [alert show];
    
//    [TimeUtil delayCall:0.01 block:^{
//        [[LLAlertView alloc] alertWithTitle:nil msg: cancelTxt:[LangUtil langForKey:@"确定"] otherTxt:nil btnClick:^(NSInteger index){
//            isShowLogin = NO;
//            [NotificationUtil postNotification:SHOW_LOGIN_NOTIFITION object:nil userinfo:nil];
//        }];
//    }];
}

-(void) showLogin{
    [TipsUtil showUpWithText:@"弹出登录界面"];
}

-(void) showLogin:(UIViewController *)curVc{
    [TipsUtil showUpWithText:@"当前控制机下弹出登录界面"];
}

-(NSString *) getImageFullPathWithPath:(NSString *)path{
    NSString *pathHead = kCON_USER_IMAGE_URL;
    return [NSString stringWithFormat:@"%@%@", pathHead, path];
}


- (NSString*) getNameByUID:(NSString*) uid
{
    NSString *name = @"";
//    UserModel *userModel = [[UserMgr sharedInstance] getUserInfoById:uid];
//    if (userModel && userModel.nickname) {
//        name = userModel.nickname;
//    }
  
    return name;
}


// 跳转到用户主页
-(void) goUserIndexWithVc:(BaseViewController *)vc uid:(NSString *)uid{
    MyViewController *uservc=[[MyViewController alloc]init];

    [vc pushViewController:uservc animated:YES];
}

// 首页跳转到用户主页
-(void) goHomeUserIndexWithVc:(BaseViewController *)vc uid:(NSString *)uid{
    MyViewController *uservc=[[MyViewController alloc]init];

    [vc pushViewController:uservc animated:YES];
}

// 跳转到用户主页,带粉丝数据，粉丝列表界面用到
-(void) goUserIndexWithVc:(BaseViewController *)vc uid:(NSString *)uid isNeedRead:(BOOL)isNeedRead dataList:(NSArray *)dataList{
    MyViewController *uservc=[[MyViewController alloc]init];

    [vc pushViewController:uservc animated:YES];
}


#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1000001) {
        [self showLogin];
    }
}

@end
