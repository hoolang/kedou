//
//  LLCustomAlertView.h
//  lovelive
//
//  Created by 91wan on 15/12/28.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>
enum {
    LLCustomAlertViewNone = 0,
    LLCustomAlertViewSuccess = 1,
    LLCustomAlertViewFail = 2,
};
typedef int LLCustomAlertViewType;
typedef void (^IntBlock)(NSInteger);

@protocol LLCustomAlertViewDelegate <NSObject>
@optional
- clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)clickedButtonAtIndexView:(UIView*)view buttonIndex:(NSInteger)buttonIndex;
@end

@interface LLCustomAlertView : UIView
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle type:(LLCustomAlertViewType)type;
-(void)show;
@property (nonatomic, assign) id<LLCustomAlertViewDelegate> delegate;
@property (nonatomic, copy) IntBlock btnClick;
@property (nonatomic, assign) BOOL isNoneCancel;
@property (nonatomic, strong) id userinfo;
@end
