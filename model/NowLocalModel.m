//
//  NowLocalModel.m
//  lovelive
//
//  Created by Circle on 15/11/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "NowLocalModel.h"

@implementation NowLocalModel
- (NowLocalModel *) initWithDic:(NSDictionary *)dic{
    return [self formatMemberWithDic:dic];
}

-(NowLocalModel *) formatMemberWithDic:(NSDictionary *)dic{
    NowLocalModel *model = [[NowLocalModel alloc] init];
   
    model.nation = [self getStringValueInDic:dic key:@"nation"];
    model.province = [self getStringValueInDic:dic key:@"province"];
    model.city = [self getStringValueInDic:dic key:@"city"];
    model.nation = [self getStringValueInDic:dic key:@"nationText"];
    model.province = [self getStringValueInDic:dic key:@"provinceText"];
    model.city = [self getStringValueInDic:dic key:@"cityText"];
    
    return model;
}
@end
