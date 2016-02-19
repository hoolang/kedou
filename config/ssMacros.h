//
//  ssMacros.h
//  lovelive
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#ifndef ssMacros_h
#define ssMacros_h
#define iSLOGIN                         [[LoginMgr sharedInstance] isLogin]
#define uSerInfo                        [[LoginMgr sharedInstance] getLoginUserInfo]
#define selfid                          uSerInfo.login_uid
#define notificationCenter              [NSNotificationCenter defaultCenter]




#define USERDEFAULT                     [NSUserDefaults standardUserDefaults]
#define SCREEN_H                        [UIScreen mainScreen].bounds.size.height
#define SCREEN_W                        [UIScreen mainScreen].bounds.size.width


#define USERDEFAULT                     [NSUserDefaults standardUserDefaults]
#define BG_COLOR_VIEW               [UIColor colorWithRed:240.0/255 green:239.0/255 blue:245.0/255 alpha:1]

#define OCCUPANCY                       @"OCCUPANCY"
#define MESSAGETYPE                     @"MESSAGETYPE"
#define MESSAGETEXT                     @"MESSAGETEXT"
#define SENDERID                        @"SENDERID"
#define OTHEROBJECT                     @"OTHEROBJECT"
#define ROOMID                          @"ROOMID"


#define VIDEOINV                        @"VIDEOINV"
#define ACCEPTINV                       @"ACCEPTINV"
#define REFUSEINV                       @"REFUSEINV"
#define TIMEOUT                         @"TIMEOUT"

#define AVPAING                         @"AVPAING"
#define TEACHERFREE                     @"TEACHERFREE"
#define ISBUSY                          @"ISBUSY"



#define WECHATSHAREFINSH                @"WECHATSHAREFINSH"
#define QQSHAREFINSH                    @"QQSHAREFINSH"
#define SINASHAREFINSH                  @"SINASHAREFINSH"
#define QQZONESHAREFINSH                @"QQZONESHAREFINSH"
#define FACEBOOKSHAREFINSH              @"FACEBOOKSHAREFINSH"



#define WECHATSHARESUCCECE              @"WECHATSHARESUCCECE"  //微信分享成功  朋友圈／好友
#define WECHATSHAREFAILED               @"WECHATSHAREFAILED"    //微信分享失败／取消  朋友圈／好友
#define WECHATNOTINSTALLED              @"WECHATNOTINSTALLED"   //没有安装微信


#define QQSHARESUCCECE                   @"QQSHARESUCCECE"      //qq分享成功  qq空间／好友
#define QQSHAREFAILED                    @"QQSHAREFAILED"       //qq分享失败／取消  qq空间／好友
#define QQNOTINSTALLED                   @"QQNOTINSTALLED"      //没有安装qq


#define SINASHARESUCCEC                 @"SINASHARESUCCEC"      //新浪微博分享成功
#define SINASHAREFAILED                 @"SINASHAREFAILED"      //新浪微博分享失败



#define ATTENTIONCHANCE                 @"ATTENTIONCHANCE"

#define WX_URL_SCHEME @"wxfbccbf18537279ec" //微信 URL
#define WB_URL_SCHEME @"wb3981352405" //微博 URL
#define QQ_URL_SCHEME @"tencent1105136082"


#define PAYPALID                        @"PAYPALID"
#define APPLEID                         @"APPLEID"

//#define kCON_RES_URL @"http://192.168.88.84/live-res/"
//#define kCON_USER_IMAGE_URL [NSString stringWithFormat:@"%@%@", kCON_RES_URL, @"user/image/"]

#define imagehost                       [NSString stringWithFormat:@"%@",kCON_USER_IMAGE_URL]

//保存银行卡的 key
#define BANKNAMEANDNO                    @"BANKNAMEANDNO"
#define BANKNAMEANDNO_UID [NSString stringWithFormat:@"%@%@",BANKNAMEANDNO,LOGIN_UID]


#define USER_INFO_WITH_UID(uid) [NSString stringWithFormat:@"%@%@",@"USER_INFO_WITH",uid]


//多语言
#define LLLang(key,mark) NSLocalizedString(key, mark)
#define LLLangHmn(key,mark) [LangUtil langForKey:key tbl:@"hmn"]
#define LLLangCzh(key) [LangUtil langForKey:key tbl:@"czh"]
#define LLLangZmb(key, mark) [LangUtil langForKey:key tbl:@"zmb"]





#define USERHEADDEFAULT                 @"head"

//获取屏幕 宽度高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCALE ([UIScreen mainScreen].scale)
//状态栏、导航栏、标签栏高度
#define STATUS_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)
#define NAVIGATIONBAR_HEIGHT (self.navigationController.navigationBar.frame.size.height)
#define TABBAR_HEIGHT (self.tabBarController.tabBar.frame.size.height)

// 计算状态栏、导航栏、标签栏高度
#define CONTENT_FRAME_HEIGHT SCREEN_HEIGHT-(STATUS_HEIGHT+NAVIGATIONBAR_HEIGHT)
#define CONTENT_FRAME_Y STATUS_HEIGHT+NAVIGATIONBAR_HEIGHT

//字体颜色
#define COLOR_FONT_WHITE 0xFFFFFF
#define COLOR_FONT_LIGHTWHITE 0xEEEEEE
#define COLOR_FONT_DARKGRAY  0x555555
#define COLOR_FONT_GRAY  0x777777
#define COLOR_FONT_LIGHTGRAY  0x999999
#define COLOR_FONT_BLACK 0x000000
// 绿色-倒计时
#define COLOR_FONT_GREEN 0x00B87E
// 绿色-倒计时
#define COLOR_FONT_RED 0xe82b48


// 灰色
#define COLOR_GRAY 0xCDCDCD
// 灰色
#define COLOR_GRAY_B2B2B2 0xB2B2B2
// 灰色
#define COLOR_GRAY_666666 0x666666
// 灰色
#define COLOR_GRAY_9F9F9F 0x9F9F9F
// 灰色
#define COLOR_GRAY_D9D9D9 0xD9D9D9
// 灰色
#define COLOR_GRAY_333333 0x333333

// 橙色
#define COLOR_ORANGE 0xF2AD2E
// 橙色
#define COLOR_CELL 0x5a5a5a

// 普通行高
#define COMMON_CELL_HEIGHT 50
// 普通table header高
#define COMMON_HEADER_HEIGHT 10
// 昵称最大长度
#define NICKNAME_LENGTH 15
// 个人介绍最大长度
#define INTRODUCE_LENGTH 200
// 普通列表标题字号
#define NORMOL_FONT_SIZE 16


//背景颜色
#define COLOR_BG_GRAY      0xEDEDED
#define COLOR_BG_ALPHABLACK     0x88000000
#define COLOR_BG_ORANGE 0xf69e21
#define COLOR_BG_ALPHARED  0x88D54A45
#define COLOR_BG_LIGHTGRAY 0xEEEEEE
#define COLOR_BG_ALPHAWHITE 0x55FFFFFF
#define COLOR_BG_WHITE     0xFFFFFF
#define COLOR_BG_DARKGRAY     0xAFAEAE
#define COLOR_BG_RED       0xD54A45
#define COLOR_BG_BLUE      0x4586DA
#define COLOR_BG_CLEAR     0x00000000
// 通用背景色
#define COLOR_BG_COMM     0xFFF2F2F2

// 通用背景图
#define BACKGROUD_IMAGE [[UIImage imageNamed:@"background2"] stretchableWidth:0.5 Height:0.1]

#define TABLE_CELL_ID   @"tableCell"

// 圆角
#define BTN_RADIUS 2.5

//rbg转UIColor(16进制)
#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA16(rgbaValue) [UIColor colorWithRed:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbaValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbaValue & 0xFF))/255.0 alpha:((float)((rgbaValue & 0xFF000000) >> 24))/255.0]

#define LOGIN_UID [[LoginMgr sharedInstance] getLoginUserInfo].login_uid
#define LOGIN_TOKEN [[LoginMgr sharedInstance] getLoginUserInfo].login_token
#define LOGIN_USERMODEL [UserMgr sharedInstance].userModel

typedef void(^SwitchBlock)(BOOL);

// language
#define ZMB  @"zmb"
#endif /* ssMacros_h */
