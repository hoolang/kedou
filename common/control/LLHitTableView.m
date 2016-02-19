//
//  LLHitTableView.m
//  lovelive
//
//  Created by Kong on 15/12/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LLHitTableView.h"

@implementation LLHitTableView

@synthesize llTableViewDelegate;


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event ];
    if (hitView == self) {
        return nil;
    }else{
        return hitView;
    }
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (llTableViewDelegate) {
        [llTableViewDelegate touchesBegan:touches withEvent:event];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if (llTableViewDelegate) {
        [llTableViewDelegate touchesMoved:touches withEvent:event];
    }
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (llTableViewDelegate) {
        [llTableViewDelegate touchesEnded:touches withEvent:event];
    }
}


@end
