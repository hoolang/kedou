//
//  LangUtil.h
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LangUtil : NSObject

+ (NSString *) langForKey:( NSString *) key;
+ (NSString *) langForKey:( NSString *) key tbl:(NSString *) tbl;


#pragma mark 多语言
+(NSBundle *)bundle;//获取当前资源文件

+(void)initUserLanguage;//初始化语言文件

+(NSString *)userLanguage;//获取应用当前语言

+(void)setUserlanguage:(NSString *)language;//设置当前语言

// 获取语言列表
+(NSArray*)getLanguageArray;

// 转换服务器语言标识
+(NSString *)getServerAccpetLanguageWithLocalKey:(NSString*)key;

// 当前语言是否为中文
+(BOOL)isChinese;

@end
