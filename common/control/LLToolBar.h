//
//  LLToolBar.h
//  lovelive
//
//  Created by Circle on 15/12/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLToolBarDelegate <NSObject>
- (void)clickTabBarLeftButton;
- (void)clickTabBarRightButton;
@end
@interface LLToolBar : UIToolbar
@property (nonatomic, weak) id<LLToolBarDelegate> llToolBarDelegate;
-(id)initWithFrame:(CGRect)frame;
@end