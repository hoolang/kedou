//
//  SimpleCellModel.m
//  lovelive
//
//  Created by Circle on 15/11/26.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "SimpleCellModel.h"

@implementation SimpleCellModel
- (SimpleCellModel *) initWithDic:(NSDictionary *)dic{
    return [self formatWithDic:dic];
}

-(SimpleCellModel *) formatWithDic:(NSDictionary *)dic{
    SimpleCellModel *model = [[SimpleCellModel alloc] init];
    model.leftText =  [self getStringValueInDic:dic key:@"leftText" ] ;
    model.rightText = [self getStringValueInDic:dic key:@"rightText"];
    model.cellValue = [self getStringValueInDic:dic key:@"cellValue"];
    model.showImgView = [self getBoolValueInDic:dic key:@"showImgView"];

    return model;
}
@end
