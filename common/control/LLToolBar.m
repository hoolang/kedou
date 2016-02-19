//
//  LLToolBar.m
//  lovelive
//
//  Created by Circle on 15/12/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LLToolBar.h"

@implementation LLToolBar

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setBarTintColor:[UIColor whiteColor]];
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50.0f, 30.0f)];
        cancelBtn.layer.cornerRadius = 4;
        //[cancelBtn setBackgroundColor:RGB16(COLOR_FONT_RED)];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:RGB16(0xF2AD2E) forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *comfirm = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W-55, 5, 50.0f, 30.0f)];
        comfirm.layer.cornerRadius = 4;
        //[comfirm setBackgroundColor:RGB16(COLOR_FONT_RED)];
        comfirm.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [comfirm setTitle:@"完成" forState:UIControlStateNormal];
        [comfirm setTitleColor:RGB16(0xF2AD2E) forState:UIControlStateNormal];
        [comfirm addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
        // 暂时不添加左侧按钮
        //[self addSubview:cancelBtn];
        [self addSubview:comfirm];
    }
    return self;
}

- (void)clickLeftBtn
{
    if ([self.llToolBarDelegate respondsToSelector:@selector(clickTabBarLeftButton)]) {
        [self.llToolBarDelegate clickTabBarLeftButton];
    }
}

- (void)clickRightBtn
{
    if ([self.llToolBarDelegate respondsToSelector:@selector(clickTabBarRightButton)]) {
        [self.llToolBarDelegate clickTabBarRightButton];
    }
}

@end
