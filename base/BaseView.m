//
//  BaseView.m
//  lovelive
//
//  Created by Kong on 15/11/24.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(void) dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:LANGUAGE_UPDATE];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
//    LLLogFunc
    // 监听语言更新，更新界面
    [NotificationUtil registerNotification:self selector:@selector(updateViewForLanguage) name:LANGUAGE_UPDATE];
    [self updateViewForLanguage];
}

#pragma mark 多语言更新界面
-(void) updateViewForLanguage
{
    LLLogFunc
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
