//
//  LogUtil.m
//  lovelive
//
//  Created by Kong on 15/11/24.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LogUtil.h"
#import "FileHelper.h"
#import "CacheHelper.h"

@implementation LogUtil

+ (void)d:(NSString *)str{
#if DEBUG
    NSLog(@"Love-Live-Debug-Info:%@", str);
#else
    
#endif
}

//将错误日志写到物理路径
+ (void)e:(NSString *)str{
    // 写入缓存 创建缓存文件夹
    NSString *logDirPath = [NSString stringWithFormat:@"%@%@",[[FileHelper sharedInstance]getDocumentPath] ,kCON_CACHE_LOG];
    
    if (![[FileHelper sharedInstance] isExistPath:logDirPath]) {
        [[FileHelper sharedInstance] createDirectory:logDirPath];
    }
    NSString *filePath = [NSString stringWithFormat:@"%@/%@-%@.txt", logDirPath, LOGIN_UID, [TimeUtil getTimestrWithDate:[NSDate date] format:@"yyyy-MM-dd--HH"]];
    if ([[FileHelper sharedInstance] isExistPath:filePath]) {
        NSString *oldStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSString *newStr = [NSString stringWithFormat:@"%@ \r\n  \r\n \r\n %@ \r\n %@", oldStr, [TimeUtil getTimestrWithDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"], str];
        [[FileHelper sharedInstance] writeObject:newStr toDestionPath:filePath];
    }else{
        [[FileHelper sharedInstance] writeObject:str toDestionPath:filePath];
    }
    
}



@end
