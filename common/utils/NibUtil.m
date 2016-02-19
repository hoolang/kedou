//
//  NibUtil.m
//  lovelive
//
//  Created by Kong on 15/12/7.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "NibUtil.h"

@implementation NibUtil

+(UIView *) loadNibViewWithNibName:(NSString *)nibname owner:(id)owner{
    
    return [[[NSBundle mainBundle] loadNibNamed:nibname owner:owner options:nil] lastObject];
}



@end
