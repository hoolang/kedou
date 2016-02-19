//
//  LangUtil.m
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import "LangUtil.h"

static NSBundle *bundle = nil;

@implementation LangUtil


+ (NSString *) langForKey:( NSString *) key{
//    NSString *str = NSLocalizedString(key, key);
    NSString *str = [bundle localizedStringForKey:(key) value:key table:nil];
    return str;
}

+ (NSString *) langForKey:( NSString *) key tbl:(nullable NSString *) tbl
{
//        return NSLocalizedString(key, key);
    return [bundle localizedStringForKey:(key) value:key table:(tbl)];
}

#pragma mark 多语言
+ ( NSBundle * )bundle{
    return bundle;
}

+(void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *string = [def valueForKey:@"userLanguage"];
    
    if(string.length == 0){
        
        //获取系统当前语言版本(中文zh-Hans,英文en)
        
        NSArray* languages = [def objectForKey:@"AppleLanguages"];
        
        NSString *current = [languages objectAtIndex:0];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:current ofType:@"lproj"];
        // 如果找不到语言
        if (!path) {
            // 处理 zh-Hans 和 zh-Hans-CN 问题
            NSArray *array = [self getLanguageArray];
            for (NSDictionary* dic in array) {
                NSString* langKey = dic[@"key"];
                if([current rangeOfString:langKey].location != NSNotFound)
                {
                    current = langKey;
                    break;
                }
            }
        }
        
        string = current;
        
        [def setValue:current forKey:@"userLanguage"];
        
        [def synchronize];//持久化，不加的话不会保存
        
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    // 如果找不到语言，启用英文版本
    if (!path) {
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }
    
    if (path) {
        bundle = [NSBundle bundleWithPath:path];//生成bundle
#pragma mark 设置app语言：TODO
        //[[HttpHelper sharedInstance] setLang:string];
    } else {
        bundle = [NSBundle mainBundle];
    }
}

+(NSString *)userLanguage
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *string = [def valueForKey:@"userLanguage"];
    return string;
}

+(void)setUserlanguage:(NSString *)language{
    if (![[self userLanguage] isEqualToString:language]) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        
        //1.第一步改变bundle的值
        NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
        
        bundle = [NSBundle bundleWithPath:path];
        
        //2.持久化
        [def setValue:language forKey:@"userLanguage"];
        
        [def synchronize];
#pragma mark 设置语言 TODO 
//        [[HttpHelper sharedInstance] setLang:language];
        // 通知语言更新
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_UPDATE object:nil userInfo:nil];
    }
}

// 获取语言列表
+(NSArray*)getLanguageArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[NSDictionary dictionaryWithObjectsAndKeys: @"English", @"title", @"en", @"key", nil]];
    [array addObject:[NSDictionary dictionaryWithObjectsAndKeys: @"简体中文", @"title", @"zh-Hans", @"key", nil]];
    return array;
}

// 转换服务器语言标识
+(NSString *)getServerAccpetLanguageWithLocalKey:(NSString*)key{
    NSDictionary *dic = [NSDictionary
                         dictionaryWithObjects:@[@"en",@"zh_cn",@"zh_cn"]
                         forKeys:@[@"en",@"zh-Hans",@"zh-Hans-CN"]];
    return dic[key];
}

+(BOOL)isChinese
{
    NSString *lang = [self userLanguage];
    NSRange range = [lang rangeOfString:@"zh"];
    if (range.location == NSNotFound) {
        return false;
    }
    return true;
}
@end
