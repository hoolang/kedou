//
//  ConstantUtil.m
//  lovelive
//
//  Created by TerryChao on 15/12/10.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "ConstantUtil.h"

@implementation ConstantUtil

// 0,1 转换成YES,ON
+(BOOL) getCommonStausByString:(NSString*) valueStaus;
{
    BOOL status = NO;
    if ([valueStaus intValue] == COMMON_STATUS_YES) {
        status = YES;
    }
    return status;
}
// YES,ON 转换成0,1
+(NSString*) getCommonStatusString:(BOOL) status
{
    if (status==YES) {
        return [NSString stringWithFormat:@"%d", (int)COMMON_STATUS_YES];
    } else {
        return [NSString stringWithFormat:@"%d", (int)COMMON_STATUS_NO];;
    }
}

// 0,1 转换成YES,ON
+(BOOL) getCommonStausByInt:(int) valueStaus;
{
    BOOL status = NO;
    if (valueStaus == COMMON_STATUS_YES) {
        status = YES;
    }
    return status;
}





@end
