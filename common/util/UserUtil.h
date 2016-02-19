//
//  UserUtil.h
//  lovelive
//
//  Created by Circle on 15/11/30.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface UserUtil : NSObject

+(UserUtil *) sharedInstance;

-(void) alertShowLogin;


/**
 *  @author ZMB, 15-11-30 20:11:56
 *
 *  显示登录界面
 *
 *  @param curVc <#curVc description#>
 */
-(void) showLogin:(UIViewController *)curVc;

-(NSString *) getImageFullPathWithPath:(NSString *)path;

- (NSString*) getNameByUID:(NSString*) uid;

// 跳转到用户主页
-(void) goUserIndexWithVc:(UIViewController *)vc uid:(NSString *)uid;
// 首页调到用户主页
-(void) goHomeUserIndexWithVc:(UIViewController *)vc uid:(NSString *)uid;
-(void) goUserIndexWithVc:(UIViewController *)vc uid:(NSString *)uid isNeedRead:(BOOL)isNeedRead dataList:(NSArray *)dataList;
@end
