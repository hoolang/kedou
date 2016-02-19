//
//  LLTextField.m
//  lovelive
//
//  Created by Kong on 15/12/21.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LLTextField.h"

@implementation LLTextField

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 15, 0);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 15, 0);
}

@end
