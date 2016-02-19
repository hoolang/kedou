//
//  NSObject+ModelUtils.h
//  lovelive
//
//  Created by 91wan on 16/1/14.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

/**
 例子
 LLHomeModel *model=[[LLHomeModel alloc]init];
 [model setAttributes:array[i]];
 [arrayData addObject:model];
 id aaadd=[model getAttr];
 NSLog(@"---%@",aaadd);
 
 */
#import <Foundation/Foundation.h>

@interface NSObject (ModelUtils)
/**
 *  NSDictionary 转 model
 *
 */
-(void)setAttributes:(NSDictionary*)dataDic;
/**
 *  model 转 NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *)getAttr;

@end
