//
//  NowLocalModel.h
//  lovelive
//
//  Created by Circle on 15/11/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseModel.h"

@interface NowLocalModel : BaseModel
@property (nonatomic, copy) NSString *nation;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *nationText;
@property (nonatomic, copy) NSString *provinceText;
@property (nonatomic, copy) NSString *cityText;

- (NowLocalModel *) initWithDic:(NSDictionary *)dic;
@end
