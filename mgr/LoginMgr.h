//
//  LoginMgr.h
//  lovelive
//
//  Created by Kong on 15/11/25.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseMgr.h"
#import "LoginUserModel.h"
#import "LocalModel.h"
#import "SimpleModel.h"
#import "NowLocalModel.h"
#import "ThemeCategoriesModel.h"

@interface LoginMgr : BaseMgr{
    NSInteger localWithServerTimeOffset;
}
@property (copy, nonatomic) NSMutableArray *themeCategories;
@property (copy, nonatomic) NSMutableArray *userLabels;
@property (assign, nonatomic)BOOL isLogining;

+ (LoginMgr*) sharedInstance;

- (BOOL) isLogin;

//本地退出缓存
-(void) logout;

// 取服务器时间，根据偏移量计算得出
-(NSTimeInterval) getServerTime;

- (void) saveLoginUserInfo:(LoginUserModel*)loginuser;
/**
 *  @author ZMB, 15-11-30 18:11:05
 *
 *  获取登录用户的ID
 *
 *  @return return value description
 */
- (NSString *) getLoginId;

- (LoginUserModel *) getLoginUserInfo;
- (LocalModel *) getLoginLocalModel;

@end







