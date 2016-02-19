//
//  UserMgr.h
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import "UserModel.h"

// 用户代理
@protocol UserDelegate <NSObject>
- (void) goUserInfoViewByUID:(NSString*) uid;
@end


@interface UserMgr : BaseMgr

@property (strong, nonatomic) NSDictionary* userInfoDic;
/**
 *  获取当然登录的userModel 
 */
@property (strong, nonatomic) UserModel* userModel;

+ (UserMgr*) sharedInstance;

@end
