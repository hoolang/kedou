//
//  Common.m
//  lovelive
//
//  Created by Circle on 15/11/25.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "Common.h"

@implementation Common
+(NSString *)getDeviceId{
    UIDevice *device = [UIDevice currentDevice];//创建设备对象
    NSLog(@"%@",device);
    return @"";//[[NSString alloc] initWithString:[device userInterfaceIdiom]];
}
@end
