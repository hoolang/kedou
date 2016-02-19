//
//  LLAlertView.m
//  lovelive
//
//  Created by Kong on 15/12/25.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LLAlertView.h"

@interface LLAlertView()<UIAlertViewDelegate>{
    IntBlock buttonClick;
}

@end

@implementation LLAlertView

+(LLAlertView *)sharedInstance{
    static LLAlertView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LLAlertView alloc] init];
    });
    return instance;
}

-(void)alertWithTitle:(NSString *)title msg:(NSString *)msg cancelTxt:(NSString *)cancelTxt otherTxt:(NSString *)otherTxt btnClick:(IntBlock)btnClick{
    buttonClick = btnClick;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTxt otherButtonTitles:otherTxt, nil];
    [alert show];
}


#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonClick) {
        buttonClick(buttonIndex);
        buttonClick = nil;
    }
}

@end
