//
//  BaseModel.m
//  lovelive
//
//  Created by Kong on 15/11/25.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


// 从字典中取值，添加过滤方法，无数据返回空串
-(NSString *) getStringValueInDic:(NSDictionary *)dic key:(NSString *)key{
    NSString *result = @"";
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic objectForKey:key] && [dic objectForKey:key] != [NSNull null]) {
            result = [NSString stringWithFormat:@"%@", [dic objectForKey:key]];
        }
    }
    return result;
}

// 从字典中取值，添加过滤方法，无数据返回0
-(NSInteger) getIntValueInDic:(NSDictionary *)dic key:(NSString *)key{
    NSInteger result = 0;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic objectForKey:key] != [NSNull null]) {
            result = [[dic objectForKey:key] integerValue];
        }
    }
    return result;
    
}

// 从字典中取值，添加过滤方法，无数据返回0
-(double) getDoubleValueInDic:(NSDictionary *)dic key:(NSString *)key {
    double result = 0;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic objectForKey:key] != [NSNull null]) {
            result = [[dic objectForKey:key] doubleValue];
        }
    }
    return result;
}
// 从字典中取值，添加过滤方法，无数据返回0
-(float) getFloatValueInDic:(NSDictionary *)dic key:(NSString *)key {
    float result = 0;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic objectForKey:key] != [NSNull null]) {
            result = [[dic objectForKey:key] floatValue];
        }
    }
    return result;
}
// 从字典中取值，添加过滤方法，无数据返回0
-(long) getLongValueInDic:(NSDictionary *)dic key:(NSString *)key {
    long result = 0;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic objectForKey:key] != [NSNull null]) {
            result = [[dic objectForKey:key] longValue];
        }
    }
    return result;
}


// 从字典中取值，添加过滤方法，无数据返回true
-(BOOL) getBoolValueInDic:(NSDictionary *)dic key:(NSString *)key{
    BOOL result = true;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic objectForKey:key] != [NSNull null]) {
            result = [[dic objectForKey:key] boolValue];
        }
    }
    return result;
}


// 从字典中取值，添加过滤方法，无数据返回空的数组
-(NSArray *) getArrayValueInDic:(NSDictionary *)dic key:(NSString *)key
{
    NSArray *result = [NSArray array];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic objectForKey:key] != [NSNull null]) {
            result = [[dic objectForKey:key] array];
        }
    }
    return result;
}




@end
