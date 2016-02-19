//
//  BaseModel.h
//  lovelive
//
//  Created by Kong on 15/11/25.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

// 从字典中取值，添加过滤方法，无数据返回空串
-(NSString *) getStringValueInDic:(NSDictionary *)dic key:(NSString *)key;
// 从字典中取值，添加过滤方法，无数据返回0
-(NSInteger) getIntValueInDic:(NSDictionary *)dic key:(NSString *)key;
// 从字典中取值，添加过滤方法，无数据返回true
-(BOOL) getBoolValueInDic:(NSDictionary *)dic key:(NSString *)key;
// 从字典中取值，添加过滤方法，无数据返回空的数组
-(NSArray *) getArrayValueInDic:(NSDictionary *)dic key:(NSString *)key;
// 从字典中取值，添加过滤方法，无数据返回0
-(double) getDoubleValueInDic:(NSDictionary *)dic key:(NSString *)key;
// 从字典中取值，添加过滤方法，无数据返回0
-(float) getFloatValueInDic:(NSDictionary *)dic key:(NSString *)key;
// 从字典中取值，添加过滤方法，无数据返回0
-(long) getLongValueInDic:(NSDictionary *)dic key:(NSString *)key;


//通过对象返回一个NSDictionary，键是属性名称，值是属性值。
//+ (NSDictionary*)getObjectData:(id)obj;

//将getObjectData方法返回的NSDictionary转化成JSON
//+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;

//直接通过NSLog输出getObjectData方法返回的NSDictionary
//+ (void)print:(id)obj;

@end
