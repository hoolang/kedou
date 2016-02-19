//
//  SimpleModel.m
//  lovelive
//
//  Created by Circle on 15/12/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "SimpleModel.h"

@implementation SimpleModel
- (SimpleModel *) initWithDic:(NSDictionary *)dic{
    return [self formatWithDic:dic];
}

-(SimpleModel *) formatWithDic:(NSDictionary *)dic{
    SimpleModel *model = [[SimpleModel alloc] init];
    
    model.sKey = [self getStringValueInDic:dic key:@"sKey"];
    model.sValue = [self getStringValueInDic:dic key:@"sValue"];

    return model;
}
@end
