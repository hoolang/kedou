//
//  LLTitleAndTextField.h
//  lovelive
//
//  Created by 91wan on 16/1/4.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLTitleAndTextField : UIView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title placeholder:(NSString*)placeholder;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITextField *textField;
/**
 *  限制字符输入的个数
 */
@property(nonatomic,assign)int maxLength;
@end
