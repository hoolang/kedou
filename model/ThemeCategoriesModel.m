//
//  ThemeCategoriesModel.m
//  lovelive
//
//  Created by Circle on 15/12/31.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "ThemeCategoriesModel.h"

@implementation ThemeCategoriesModel
//"id": "2015122122250228201779096",
//"parent_id": "2015122122142866701734494",
//"name": "生活",
//"priority": null,
//"last_update_time": 1450707902280
- (ThemeCategoriesModel *) initWithDic:(NSDictionary *)dic{
    return [self formatWithDic:dic];
}

-(ThemeCategoriesModel *) formatWithDic:(NSDictionary *)dic{
    ThemeCategoriesModel *model = [[ThemeCategoriesModel alloc] init];
    model.id = [self getStringValueInDic:dic key:@"id"];
    model.parent_id = [self getStringValueInDic:dic key:@"parent_id"];
    model.name = [self getStringValueInDic:dic key:@"name"];
    model.priority = [self getStringValueInDic:dic key:@"last_update_time"];
    model.isSlected = false;
    return model;
}
@end
