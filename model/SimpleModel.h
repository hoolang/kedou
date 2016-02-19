//
//  SimpleModel.h
//  lovelive
//
//  Created by Circle on 15/12/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleModel : BaseModel
@property (copy, nonatomic) NSString *sKey;
@property (copy, nonatomic) NSString *sValue;


- (SimpleModel *) initWithDic:(NSDictionary *)dic;
@end
