//
//  Constants.h
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kCON_DEBUG NO
#define kCON_ISSHOWWELCOME NO
#define kCON_CACHE_PATH @"/lovelive"
#define kCON_CACHE_DATA @"/lovelive/Data/"
#define kCON_CACHE_LOG @"/lovelive/log/"
#define kCON_CACHE_IMAGE @"images/"
#define kCON_CACHE_DEFAULT_TIME 1800

#define kPAGE_SIZE 20

#define kAPIVersion               @"1.0"
#define kCON_APP_KEY @"liyc"
#define kCON_APP_SECRET @"liyc"

#ifdef __COM__
#define kCON_API_URL @"http://api.loveorange.com/live-api/"
#define kCON_RES_URL @"http://res.loveorange.com/live/resource/"
#define kCON_UPDATE_URL @"http://api.loveorange.com/live-api/base/version/ios"
#define kIM_ADMIN_ACCOUNT @"liveadmin" // 我们自己定义的系统IM账号
#else

#ifdef DEBUG
#define kCON_API_URL @"http://192.168.1.28:80/liveapi/"
#define kCON_RES_URL @"http://192.168.1.28/live-res/"
#define kCON_UPDATE_URL @"http://192.168.1.28/liveapi/base/version/ios"
#define kIM_ADMIN_ACCOUNT @"liveadminDev" // 我们自己定义的系统IM账号
#else
#define kCON_API_URL @"http://api.loveorange.com/live-api/"
#define kCON_RES_URL @"http://res.loveorange.com/live/resource/"
#define kCON_UPDATE_URL @"http://api.loveorange.com/live-api/base/version/ios"
#define kIM_ADMIN_ACCOUNT @"liveadmin" // 我们自己定义的系统IM账号
#endif

#endif

#define kCON_LICENSE_URL @"http://res.loveorange.com/live/resource/system/protocol.html" //用户协议地址

#define kCON_USER_IMAGE_URL [NSString stringWithFormat:@"%@%@", kCON_RES_URL, @"user/image/"]
#define kCON_USER_VIDEO_URL [NSString stringWithFormat:@"%@%@", kCON_RES_URL, @"user/video/"]
#define kCON_USER_PHOTO_URL [NSString stringWithFormat:@"%@%@", kCON_RES_URL, @"account/photo/load"]
#define GET_IMAGE_URL(str) [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kCON_USER_IMAGE_URL, str]]
#define GET_THUMBNAIL_URL(str) [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kCON_USER_IMAGE_URL, [str getThumbnailImageURL]]]   //缩略图 NSURL
#define PLACEHOLDER_IMAGE [UIImage imageNamed:@"head"] //占位图片
#define UIIMAGE_CREATE(str) [UIImage imageNamed:str] //创建一个图片

//发布一对一 图片地址
#define kCON_1V1_IMAGE_NAME @"system/singleLive/mark.png"
#define kCON_PUBLISH_1V1_IMAGE_URL [NSString stringWithFormat:@"%@%@", kCON_RES_URL, kCON_1V1_IMAGE_NAME]

#define kACCOUNT_TYPE 1774      //集成：账号对应的accountType
#define kSDK_APPID 1400003264   //集成：业务在TLS申请账号集成时得到的appid

#define kWX_APP_ID          @"wxfbccbf18537279ec"               //微信APPID
//#define kWX_API_KEY      @""    //微信apikey  不在前端保存 使用后端签名
//#define kWX_MCH_ID          @""                       //微信商户号
//paypal 支付
#define kPAYPAL_CLIENT_ID_FOR_PRODUCTION @"Ac60p32tUgWPbwGYrFjBM9uf5alOKQRLvOGzEPrO1HoFye8knUhMj8cZho19kheEW9c34LAd2hYyDNor"
#define kPAYPAL_CLIENT_ID_FOR_SANDBOX @"ASOWE-bDeXvrndaf8CHz4zLjzUAS0PcBCXJcluEx9v8BlBsrsYmNd0pmx9HTFziTgOsIhFjF-bpEiD_N"

//////////////////////////////
#define USER_CENTER_HEADVIEW_HEIGHT 232
#define USER_CENTER_TOP_HEIGHT USER_CENTER_HEADVIEW_HEIGHT - 64
//////////////////////////////

#define USERDEFAULT                     [NSUserDefaults standardUserDefaults]
#define SCREEN_H                        [UIScreen mainScreen].bounds.size.height
#define SCREEN_W                        [UIScreen mainScreen].bounds.size.width

// RGB颜色
#define LLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define LLRandomColor LLColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
//是否已经登录
#define IS_LOGIN [[LoginMgr sharedInstance] isLogin]
//版本>=IOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//////////////////////////////

#ifdef DEBUG // 处于开发阶段
#define LLLog(...) NSLog(__VA_ARGS__)
#else // 处于发布阶段,一处Log
#define LLLog(...)
#endif

// 方法输出
#define LLLogFunc LLLog(@"%s", __func__);

// 弱引用
#define LLWeakSelf __weak typeof(self) weakSelf = self;


/* **********键盘状态********** */
typedef NS_ENUM(NSInteger, KB_STATUS){
    KB_HIDE = 1, //已隐藏
    KB_HIDE_ING = 2, // 隐藏的动画过程中
    KB_SHOW = 3,//已显示
    KB_SHOW_ING = 4, //显示的动画过程中
};


#endif /* Constants_h */
