//
//  NSDictionary+Utils.m
//  lovelive
//
//  Created by 91wan on 16/1/14.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)
-(NSString *)string
{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return json;
}
@end
