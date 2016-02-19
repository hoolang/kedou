//
//  SimpleCellModel.h
//  lovelive
//
//  Created by Circle on 15/11/26.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseModel.h"

@interface SimpleCellModel : BaseModel
@property (nonatomic, copy) NSString *leftText;
@property (nonatomic, copy) NSString *rightText;
@property (nonatomic, copy) NSString *cellValue;
@property (nonatomic, assign) BOOL showImgView;

- (SimpleCellModel *) initWithDic:(NSDictionary *)dic;

- (SimpleCellModel *) formatWithDic:(NSDictionary *)dic;
@end
