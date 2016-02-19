//
//  LLWithdrawPwdView.h
//  lovelive
//
//  Created by 91wan on 16/1/6.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLWithdrawPwdViewDelegate <NSObject>
@optional
- (void)textFieldDidEnd:(NSString *)text;
- (void)textFieldBackspeace:(NSString *)text;
@end
@interface LLWithdrawPwdView : UIView
@property(nonatomic,weak)   id<LLWithdrawPwdViewDelegate> delegate;
@property(nonatomic,readonly)NSString *text;
-(void)setPwdZero;
@end
