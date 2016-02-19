//
//  LLPwdAlertView.h
//  lovelive
//
//  Created by 91wan on 16/1/6.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLPwdAlertView : UIView
- (instancetype)initWithTitle:(NSString *)title;
@property (nonatomic, strong) stringBlock back;
-(void)show;
@end
