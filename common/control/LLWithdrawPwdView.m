//
//  LLWithdrawPwdView.m
//  lovelive
//
//  Created by 91wan on 16/1/6.
//  Copyright © 2016年 LoveOrange. All rights reserved.
// 提现密码框

#import "LLWithdrawPwdView.h"

@interface LLWithdrawPwdView()<UITextFieldDelegate>
{
    UIButton *_tintView;
    NSString *_pwd;
    UITextField *_pwdText;
}
@end
@implementation LLWithdrawPwdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //密码框背景
        UIColor *color=LLColor(0xcd, 0xcd, 0xcd);
        UIView *midView=[[UIView alloc]initWithFrame:self.bounds];
        midView.backgroundColor=[UIColor whiteColor];
        midView.layer.borderColor =color.CGColor;
        midView.layer.borderWidth =0.5;
        midView.layer.cornerRadius=3;
        midView.clipsToBounds = YES;
        for (int i=1; i<6; i++) {
            UIView *row=[[UIView alloc]initWithFrame:CGRectMake(i*midView.height, 0, 0.5, midView.height)];
            row.backgroundColor=color;
            [midView addSubview:row];
        }
        //密码框前景  点的显示
        _tintView=[[UIButton alloc]initWithFrame:midView.bounds];
        [midView addSubview:_tintView];
        [_tintView addTarget:self action:@selector(tintViewDid) forControlEvents:UIControlEventTouchUpInside];
        for (int i=0; i<6; i++) {
            //黑点
            UIView *yuan=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
            yuan.layer.cornerRadius=yuan.height/2;
            yuan.clipsToBounds = YES;
            yuan.backgroundColor=[UIColor blackColor];
            [_tintView addSubview:yuan];
            yuan.centerY=_tintView.height/2;
            yuan.centerX=_tintView.height/2+(i*_tintView.height);
            yuan.hidden=YES;
        }
        
        
        _pwdText=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        [self addSubview:_pwdText];
        [self addSubview:midView];
        _pwdText.keyboardType=UIKeyboardTypeNumberPad;
        _pwdText.secureTextEntry=YES;
        _pwdText.font=[UIFont systemFontOfSize:1];
        _pwdText.delegate=self;
        [_pwdText becomeFirstResponder];
 
        
    }
    return self;
}
-(void)tintViewDid
{
    [_pwdText becomeFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *didString=[NSString stringWithFormat:@"%@%@",textField.text,string];
    if([string isEqualToString:@"\n"]){
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    }else if (string.length == 0){
        //判断是不是删除键  如果是只删一个字符
        textField.text = [textField.text substringToIndex:textField.text.length - 1];
        didString = textField.text;
        [self setPwdCount:didString.length];
        if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldBackspeace:)]) {
            [self.delegate textFieldBackspeace:didString];
        }
        return NO;
    }else if (string.length >1){
        //判断是不是一个字符
        return NO;
    }else if(didString.length > 6){
        //输入的字符个数大于10，则无法继续输入，返回NO表示禁止输入
        return NO;
    }
    [self setPwdCount:didString.length];
    if (didString.length == 6)
    {
        [self performSelector:@selector(textFieldDidEnd) withObject:self afterDelay:0.3];
        
    }
    return YES;
}
-(void)setPwdCount:(NSUInteger)count
{
    _text=_pwdText.text;
    int i=0;
    for (UIView *view in _tintView.subviews) {
        if (i<count)
            view.hidden=NO;
        else
            view.hidden=YES;
        i++;
    }
}
-(void)textFieldDidEnd
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidEnd:)]) {
        [self.delegate textFieldDidEnd:_pwdText.text];
    }
}
-(void)setPwdZero
{
    _pwdText.text=@"";
    [self setPwdCount:0];
}
@end
