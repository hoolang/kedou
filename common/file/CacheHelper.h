//
//  CacheHelper
//  guanjia
//
//  Created by kong on 13-9-17.
//  Copyright (c) 2013年 lsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileHelper.h"

@interface CacheHelper : NSObject

+ (CacheHelper*) sharedInstance;

/*
 * 判断是否取缓存
 *
 */
-(BOOL)isLoadCache:(NSString *)url cacheTime:(int)cacheTime;


/*
 * 取缓存文件名，不带路径
 */
-(NSString *)getCacheFileName:(NSString *)url;

/*
 * 取缓存文件路径
 */
-(NSString *)getCacheDataFilePath:(NSString *)url;

/*
 * 写入缓存
 */
-(void)writeCacheWithData:(NSString *)data url:(NSString *)url;

/*
 * 读取缓存
 */
-(NSString *)readCacheFileWithUrl:(NSString *)url;

@end
