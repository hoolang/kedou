//
//  VersionMgr.m
//  lovelive
//
//  Created by Kong on 15/12/29.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "VersionMgr.h"

@implementation VersionMgr

+(VersionMgr *)sharedInstance{
    static VersionMgr *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VersionMgr alloc] init];
    });
    return instance;
}

// 检查更新
-(void)checkUpdateWithUrl:(NSString *)url{
    
//    [[HttpHelper sharedInstance] getJSON:url completeBlock:^(id data){
//        NSDictionary *dic = data[0];
//        NSString *version = [dic objectForKey:@"version"];
//        NSString *releaseNotes = [dic objectForKey:@"releaseNotes"];
//        NSLog(@"version --> %@", version);
//        //NSString *trackName = [dic objectForKey:@"trackName"];
//        __block NSString *trackViewUrl = [dic objectForKey:@"trackViewUrl"];
//        
//        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//        NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
//        
//        if (![version isEqual:currentVersion]) {
//            [[LLAlertView sharedInstance] alertWithTitle:@"版本更新" msg:releaseNotes cancelTxt:@"取消" otherTxt:@"更新" btnClick:^(NSInteger index){
//                if (index == 1) {
//                    NSLog(@"url------> %@", trackViewUrl);
//                    NSURL *url = [NSURL URLWithString:trackViewUrl];
//                    [[UIApplication sharedApplication] openURL:url];
//                }
//            }];
//        }
//    } failedBlock:^(NSString *str){
//        NSLog(@"http error: %@", str);
//    }];
}


/**
 *  取当前版本号
 *
 *  @return
 */
-(NSString *)getAppCurrentVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}

@end
