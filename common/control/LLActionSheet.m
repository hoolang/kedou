//
//  LLActionSheet.m
//  lovelive
//
//  Created by 91wan on 16/1/4.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "LLActionSheet.h"

@interface LLActionSheet()
{
    UIView *_main;
    int _count;
}

@end
@implementation LLActionSheet
- (instancetype)initWithTitle:(NSString *)title delegate:(id<LLActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        _count=0;
        _cancelButtonIndex=-1;
        self.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.frame=[UIScreen mainScreen].bounds;
        _main=[[UIView alloc]initWithFrame:CGRectZero];
        _main.width=SCREEN_W;
        [self addSubview:_main];
        _main.backgroundColor=LLColor(0xe6, 0xe6, 0xe9);
        _otherTitles=[NSMutableArray array];
        if (otherButtonTitles) {
            [_otherTitles addObject:otherButtonTitles];
            va_list argList;
            //定义一个 va_list 指针来访问参数表
            va_start(argList, otherButtonTitles);
            //初始化 va_list，让它指向第一个变参，otherButtonTitles 这里是第一个参数，虽然加了s,它不是数组。
            id arg;
            while ((arg = va_arg(argList, id)))//调用 va_arg 依次取出 参数，它会自带指向下一个参数
            {
                [_otherTitles addObject:arg];
            }
            va_end(argList); // 收尾，记得关闭关闭 va_list
        }
        CGFloat bottom=0;
        for (int i=0; i<_otherTitles.count; i++) {
            UIButton *btn=[self createBtnWithTitle:_otherTitles[i]];
            btn.top=bottom;
            bottom=btn.bottom+0.5;
        }
        if (cancelButtonTitle) {
            if (bottom>0)bottom+=5.5;
            UIButton *btn=[self createBtnWithTitle:cancelButtonTitle];
            [btn setTitleColor:LLColor(0x9f, 0x9f, 0x9f) forState:UIControlStateNormal];
            btn.top=bottom;
            bottom=btn.bottom;
            _cancelButtonIndex=btn.tag;
        }
        _main.height=bottom;
        self.delegate=delegate;
    }
    return self;
}
-(UIButton *)createBtnWithTitle:(NSString *)title
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn setTitleColor:LLColor(0xf2, 0xad, 0x2e) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 0, _main.width, 50);
    [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage createImageWithColor:LLColor(0xe6, 0xe6, 0xe6)] forState:UIControlStateHighlighted];
    btn.tag=_count;
    _count++;
    [_main addSubview:btn];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(void)showInView:(UIView *)view
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    _main.top=self.height;
    [UIView animateWithDuration:0.2 animations:^{
        _main.top=self.height-_main.height;
    } completion:^(BOOL finished) {
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self close];
}
-(void)clicked:(UIButton *)btn
{
    [self close];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:btn.tag];
    }
}
-(void)close
{
    [UIView animateWithDuration:0.2 animations:^{
        _main.top=self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
@end
