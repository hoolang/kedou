//
//  LLHitTableView.h
//  lovelive
//
//  Created by Kong on 15/12/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLHitTableViewDelegate <NSObject>

@optional


-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

@interface LLHitTableView : UITableView

@property (nonatomic, assign) id<LLHitTableViewDelegate> llTableViewDelegate;

@end
