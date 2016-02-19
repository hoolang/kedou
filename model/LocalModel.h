//
//  LocalModel.h
//  lovelive
//
//  Created by Circle on 15/11/26.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseModel.h"
@interface LocalModel : BaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *areanumber;
@property (nonatomic, copy) NSArray *localArray;
- (LocalModel *) initWithDic:(NSDictionary *)dic;
@end

