//
//  Member.h
//  lovelive
//
//  Created by Kong on 15/11/25.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "ObjectUtil.h"

@interface LoginUserModel : BaseModel


@property (nonatomic, strong) NSString *login_uid;
@property (nonatomic,strong) NSString *login_token;
@property (nonatomic,strong) NSString *tls_usersin;

/* 以下是getBasic 数据*/
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *user_type;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *nation;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *nationality;
@property (nonatomic,strong) NSString *signature;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *register_time;
@property (nonatomic,strong) NSString *introduce;
@property (nonatomic,strong) NSString *teaching_direction;
@property (nonatomic,strong) NSString *charging_standard;
@property (nonatomic,strong) NSString *evaluate_star;
@property (nonatomic,strong) NSString *online_status;
@property (nonatomic,strong) NSString *verify_status;
@property (nonatomic,strong) NSString *notice_status;

- (LoginUserModel *) initWithDic:(NSDictionary *)dic;

- (LoginUserModel *) formatMemberWithDic:(NSDictionary *)dic;


@end
