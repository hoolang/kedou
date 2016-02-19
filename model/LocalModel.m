//
//  LocalModel.m
//  lovelive
//
//  Created by Circle on 15/11/26.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LocalModel.h"
@implementation LocalModel
- (LocalModel *) initWithDic:(NSDictionary *)dic{
    return [self formatMemberWithDic:dic];
}

-(LocalModel *) formatMemberWithDic:(NSDictionary *)dic{
    LocalModel *model = [[LocalModel alloc] init];
    model.name =  [self getStringValueInDic:dic key:@"name" ] ;
    model.code = [self getStringValueInDic:dic key:@"code"];
    model.areanumber = [self getStringValueInDic:dic key:@"areanumber"];
    model.localArray = [self getArrayValueInDic:dic key:@"localArray"];
   
    return model;
}
@end
