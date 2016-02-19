//
//  LLPwdAlertView.m
//  lovelive
//
//  Created by 91wan on 16/1/6.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "LLPwdAlertView.h"
#import "LLWithdrawPwdView.h"
#import "ImageUtil.h"
#define anis 0.2
@interface LLPwdAlertView()<LLWithdrawPwdViewDelegate>
{
    UIView *_bgView;
    UIImageView *_imageView;
}
@end
@implementation LLPwdAlertView
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        CGFloat left=25;
        
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
        
        UILabel *msg=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        msg.font=[UIFont systemFontOfSize:15];
        msg.numberOfLines=2;
        msg.text=title;
        msg.textAlignment=NSTextAlignmentCenter;
        msg.textColor=LLColor(0x5b, 0x56, 0x56);
        [midView addSubview:msg];
        [msg sizeToFit];
        msg.top=20;
        msg.centerX=midView.width/2;
        
        
        midView.top=0;
        midView.height=125;
        _bgView.height= midView.bottom;
        _bgView.bottom=self.height-262;
        
        CGFloat midW=210;
        LLWithdrawPwdView *pwdView=[[LLWithdrawPwdView alloc]initWithFrame:CGRectMake((midView.width-midW)/2, msg.bottom+21, midW, 35)];
        [midView addSubview:pwdView];
        pwdView.delegate=self;
        
        
        UIImage *image=[ImageUtil createImageFromView:_bgView];
        _imageView=[[UIImageView alloc]initWithFrame:_bgView.frame];
        _imageView.image=image;
        [self addSubview:_imageView];
        _imageView.hidden=YES;


    }
    return self;
}
-(void)textFieldDidEnd:(NSString *)text
{
    [self endEditing:YES];
    UIImage *image=[ImageUtil createImageFromView:_bgView];
    _bgView.hidden=YES;
    _imageView.image=image;
    _imageView.hidden=NO;
    [UIView animateWithDuration:anis animations:^{
        _imageView.frame=CGRectMake(_bgView.left+_bgView.width*0.1, _bgView.top+_bgView.height*0.1, _bgView.width*0.8, _bgView.height*0.8);
    } completion:^(BOOL finished) {
        if (_back) {
            _back(text);
        }
        [self removeFromSuperview];
    }];
}
-(void)show
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    _bgView.hidden=YES;
    _imageView.hidden=NO;
    _imageView.frame=CGRectMake(_bgView.left+_bgView.width*0.1, _bgView.top+_bgView.height*0.1, _bgView.width*0.8, _bgView.height*0.8);
    [UIView animateWithDuration:anis animations:^{
        _imageView.frame=CGRectMake(_bgView.left-_bgView.width*0.05, _bgView.top-_bgView.height*0.05, _bgView.width*1.1, _bgView.height*1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:anis animations:^{
            _imageView.frame=_bgView.frame;
        } completion:^(BOOL finished) {
            _bgView.hidden=NO;
            _imageView.hidden=YES;
        }];
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self close];
}

-(void)close
{
    UIImage *image=[ImageUtil createImageFromView:_bgView];
    _bgView.hidden=YES;
    _imageView.image=image;
    _imageView.hidden=NO;
    [UIView animateWithDuration:anis animations:^{
        _imageView.frame=CGRectMake(_bgView.left+_bgView.width*0.1, _bgView.top+_bgView.height*0.1, _bgView.width*0.8, _bgView.height*0.8);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
