//
//  LLTitleAndTextField.m
//  lovelive
//
//  Created by 91wan on 16/1/4.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "LLTitleAndTextField.h"
@interface LLTitleAndTextField()<UITextFieldDelegate>
@end
@implementation LLTitleAndTextField

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title placeholder:(NSString*)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 60, self.height)];
        _titleLabel.textColor=LLColor(0x5a, 0x5a, 0x5a);
        _titleLabel.font=[UIFont systemFontOfSize:14];
        _titleLabel.text=title;
//        titleLabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:_titleLabel];
        
        CGFloat textX=_titleLabel.right+10;
        _textField=[[UITextField alloc]initWithFrame:CGRectMake(textX, 0, self.width-textX, self.height)];
        _textField.font=_titleLabel.font;
        _textField.textColor=_titleLabel.textColor;
        _textField.placeholder=placeholder;
        _textField.delegate=self;
        [self addSubview:_textField];
        _maxLength=30;
    }
    return self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *didString=[NSString stringWithFormat:@"%@%@",textField.text,string];
    if([string isEqualToString:@"\n"]){
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    }else if (string.length == 0){
        //判断是不是删除键
        return YES;
    }else if(didString.length > _maxLength){
        //输入的字符个数大于10，则无法继续输入，返回NO表示禁止输入
        return NO;
    }
    return YES;
}
@end
