//
//  LLActionSheet.h
//  lovelive
//
//  Created by 91wan on 16/1/4.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLActionSheetDelegate;
@interface LLActionSheet : UIView

- (instancetype)initWithTitle:(NSString *)title delegate:(id<LLActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
@property(nonatomic,weak) id<LLActionSheetDelegate> delegate;
-(void)showInView:(UIView *)view;
@property(nonatomic,strong,readonly)NSMutableArray *otherTitles;
@property(nonatomic) NSInteger cancelButtonIndex;      // if the delegate does not implement -actionSheetCancel:, we pretend this button was clicked on. default is -1
@end

@protocol LLActionSheetDelegate <NSObject>
@optional
- (void)actionSheet:(LLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex ;
@end