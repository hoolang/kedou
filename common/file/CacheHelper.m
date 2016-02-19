//
//  CacheHelper.m
//  guanjia
//
//  Created by kong on 13-9-17.
//  Copyright (c) 2013年 lsw. All rights reserved.
//

#import "CacheHelper.h"
#import "NSString+Utils.h"


static CacheHelper *instance;

@implementation CacheHelper


+ (CacheHelper*) sharedInstance{
    if (instance == nil) {
        instance = [[CacheHelper alloc]init];
    }
    return  instance;
}

//判断缓存
-(BOOL)isLoadCache:(NSString *)url cacheTime:(int)cacheTime{
    BOOL result = NO;
    NSString *path = [NSString stringWithFormat:@"%@%@%@",[[FileHelper sharedInstance]getDocumentPath],kCON_CACHE_DATA,[self getCacheFileName:url] ];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSDictionary* attributes = [fileManager attributesOfItemAtPath:path error:nil];
    
    if (attributes != nil) {
        NSDate *date = (NSDate*)[attributes objectForKey:NSFileModificationDate];
        long lastTime = (long)[date timeIntervalSince1970];
        long nowTime = (long)[[NSDate date] timeIntervalSince1970];
        if ((nowTime - lastTime) < cacheTime) {
            result = YES;
        }
    }
    return result;
}

-(NSString *)getCacheFileName:(NSString *)url{
    NSString *result = @"";
    NSArray *arr =[url componentsSeparatedByString:@"&"];
    for (NSString *item in arr) {
        NSString *str = [[item componentsSeparatedByString:@"="] objectAtIndex:0];
        if (![str isEqual:@"current"]&& ![str isEqual:@"sign"]) {
            result = [ result stringByAppendingString:item ];
        }
    }
    return [result toMd5];
}

-(NSString *)getCacheDataFilePath:(NSString *)url{
    return [NSString stringWithFormat:@"%@%@%@",[[FileHelper sharedInstance]getDocumentPath],kCON_CACHE_DATA,[self getCacheFileName:url] ];
}

-(void)writeCacheWithData:(NSString *)data url:(NSString *)url{
    [[FileHelper sharedInstance] writeObject:data toDestionPath:[self getCacheDataFilePath:url]];
}

-(NSString *)readCacheFileWithUrl:(NSString *)url{
    return [[NSString alloc] initWithContentsOfFile:[self getCacheDataFilePath:url] encoding:NSUTF8StringEncoding error:nil];
}


@end
