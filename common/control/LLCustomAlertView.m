//
//  LLCustomAlertView.m
//  lovelive
//
//  Created by 91wan on 15/12/28.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LLCustomAlertView.h"
#define scale 0.8
@interface LLCustomAlertView()
{
    UIView *_bgView;
    UIImageView *_imageView;
}
@end

@implementation LLCustomAlertView

@synthesize userinfo;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle type:(LLCustomAlertViewType)type
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        CGFloat left=25;
        
        self.delegate = delegate;
        
        //添加一个背景视图
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(left,0, self.width-2*left , 200)];
        [self addSubview:_bgView];
        
        UIView *midView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _bgView.width, _bgView.height)];
        [_bgView addSubview:midView];
        midView.layer.cornerRadius=5;
        midView.clipsToBounds = YES;
        midView.backgroundColor=[UIColor whiteColor];
        
        UIView *top=[[UIView alloc]initWithFrame:CGRectMake(0, 0, midView.width, 4)];
        [midView addSubview:top];
        top.backgroundColor=LLColor(0xf2, 0xad, 0x2e);
        CGFloat Padding=30;
        CGFloat iconH=0;
        if ( type!=LLCustomAlertViewNone)iconH=52;
        
        UILabel *msg=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, midView.width, self.height)];
        msg.font=[UIFont systemFontOfSize:15];
        msg.numberOfLines=2;
        msg.text=message;
        msg.textAlignment=NSTextAlignmentCenter;
        msg.textColor=LLColor(0x5b, 0x56, 0x56);
        [midView addSubview:msg];
        [msg sizeToFit];
        msg.top=Padding+iconH/2;
        msg.centerX=midView.width/2;
        
        CGFloat btnPadding=17;
        CGFloat bottom=msg.bottom+Padding;
        if (doneButtonTitle) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [midView addSubview:btn];
            [btn setTitle:doneButtonTitle forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:13];
            btn.frame=CGRectMake(btnPadding, bottom, midView.width-2*btnPadding, 37);
            [btn setBackgroundImage:[UIImage imageWithColor:top.backgroundColor andSize:btn.frame.size] forState:UIControlStateNormal];
            btn.layer.cornerRadius=3;
            btn.clipsToBounds = YES;
            btn.tag=0;
            [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            bottom=btn.bottom+btnPadding;
        }
        
        if (cancelButtonTitle) {
            UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [midView addSubview:cancelBtn];
            [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [cancelBtn setTitleColor:msg.textColor forState:UIControlStateNormal];
            cancelBtn.titleLabel.font=[UIFont systemFontOfSize:13];
            cancelBtn.frame=CGRectMake(btnPadding, bottom, midView.width-2*btnPadding, 37);
            [cancelBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] andSize:cancelBtn.frame.size] forState:UIControlStateNormal];
            cancelBtn.layer.cornerRadius=3;
            cancelBtn.clipsToBounds = YES;
            [cancelBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            cancelBtn.tag=1;
            bottom=cancelBtn.bottom+btnPadding;
        }
        midView.top=iconH/2;
        midView.height=bottom;
        _bgView.height= midView.bottom;
        _bgView.centerY=self.height/2;
        
        //头像
        if ( type!=LLCustomAlertViewNone) {
            NSString *imageName=@"fail";//type==2 LLCustomAlertViewFail
            if (type==LLCustomAlertViewSuccess)imageName=@"success";
            UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, iconH, iconH)];
            icon.image=[UIImage imageNamed:imageName];
            icon.centerX=midView.centerX;
            icon.centerY=midView.top;
            [_bgView addSubview:icon];
        }
        
        UIImage *image=[ImageUtil createImageFromView:_bgView];
        _imageView=[[UIImageView alloc]initWithFrame:_bgView.frame];
        _imageView.image=image;
        [self addSubview:_imageView];
        _imageView.hidden=YES;
        
        
    }
    return self;
}
-(void)show
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    _bgView.hidden=YES;
    _imageView.hidden=NO;
    _imageView.width*=scale;
    _imageView.height*=scale;
    _imageView.center=self.contentCenter;
    CGFloat sc=1-scale;
    [UIView animateWithDuration:0.2 animations:^{
        _imageView.frame=CGRectMake(_bgView.left-_bgView.width*(sc/4), _bgView.top-_bgView.height*(sc/4), _bgView.width*(1+sc/2), _bgView.height*(1+sc/2));
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _imageView.frame=_bgView.frame;
            _imageView.center=self.contentCenter;
        } completion:^(BOOL finished) {
            _bgView.hidden=NO;
            _imageView.hidden=YES;
        }];
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   if(_isNoneCancel) [self close];
}
-(void)clicked:(UIButton *)btn
{
    [self close];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedButtonAtIndex:)]) {
        [self.delegate clickedButtonAtIndex:btn.tag];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedButtonAtIndexView:buttonIndex:)]) {
        [self.delegate clickedButtonAtIndexView:self buttonIndex:btn.tag];
    }
    if (_btnClick) {
        _btnClick(btn.tag);
    }
}
-(void)close
{
    _bgView.hidden=YES;
    _imageView.hidden=NO;
    CGFloat sc=1-scale;
    [UIView animateWithDuration:0.2 animations:^{
        _imageView.frame=CGRectMake(_bgView.left+_bgView.width*(sc/2), _bgView.top+_bgView.height*(sc/2), _bgView.width*scale, _bgView.height*scale);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
@end
