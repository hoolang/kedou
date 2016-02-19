//
//  LLAlertView.h
//  lovelive
//
//  Created by Kong on 15/12/25.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^IntBlock)(NSInteger);

@interface LLAlertView : NSObject

+(LLAlertView *)sharedInstance;

-(void)alertWithTitle:(NSString *)title msg:(NSString *)msg cancelTxt:(NSString *)cancelTxt otherTxt:(NSString *)otherTxt btnClick:(IntBlock)btnClick;

@end
