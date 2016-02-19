//
//  BaseMgr.m
//  lovelive
//
//  Created by Kong on 15/11/23.
//  Copyright © 2015年 Kong. All rights reserved.
//

#import "BaseMgr.h"


@interface BaseMgr(){
    MBProgressHUD *waitView;
}

@end

@implementation BaseMgr

- (id) init{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)removeWaitView{
    if (waitView) {
        [waitView removeFromSuperview];
        waitView = nil;
    }
}

-(void)showWaitView{
    if (waitView) {
        [self removeWaitView];
    }
    waitView = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
}

@end
