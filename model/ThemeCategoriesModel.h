//
//  ThemeCategoriesModel.h
//  lovelive
//
//  Created by Circle on 15/12/31.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseModel.h"

@interface ThemeCategoriesModel : BaseModel
//"id": "2015122122250228201779096",
//"parent_id": "2015122122142866701734494",
//"name": "生活",
//"priority": null,
//"last_update_time": 1450707902280
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *parent_id;
@property (copy, nonatomic) NSString *key;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *priority;
@property (copy, nonatomic) NSString *last_update_time;
@property (assign, nonatomic) BOOL isSlected;
- (ThemeCategoriesModel *) initWithDic:(NSDictionary *)dic;
@end