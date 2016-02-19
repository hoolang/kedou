//
//  VersionMgr.h
//  lovelive
//
//  Created by Kong on 15/12/29.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionMgr : NSObject

+(VersionMgr *)sharedInstance;

// 检查更新
-(void)checkUpdateWithUrl:(NSString *)url;

/**
 *  取当前版本号
 *
 *  @return
 */
-(NSString *)getAppCurrentVersion;

@end
