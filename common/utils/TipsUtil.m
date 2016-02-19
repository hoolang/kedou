//
//  TipsUtil.m
//  lovelive
//
//  Created by Circle on 16/1/8.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "TipsUtil.h"
#define DEFAULT_EDGE 24.0f
#define DEFAULT_SPACE_IMG_TEXT 5.0f
#define DEFAULT_RATE_WIDTH 0.8f
#define DEFAULT_DURATION 0.5f
#define DEFAULT_ANIMATON_DURATION 0.3f
#define DEFAULT_HEIGHT 64.0f
#define DEFAULT_UP_HEIGHT 35.0f

@interface TipsUtil()
@property(nonatomic,strong) UIViewController *controller;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) UIImageView *imageBackground;
@property(nonatomic,strong) UILabel *textLabel;

@end
@implementation TipsUtil

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
        self.layer.cornerRadius = 5.0f;
        
        _textLabel = [[UILabel alloc] initWithFrame:frame];
        [_textLabel setFont:[UIFont systemFontOfSize:20]];
        self.textLabel.textColor = [UIColor whiteColor];
        self.duration = DEFAULT_DURATION;
        self.imageBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background2"]];
        self.imageBackground.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.imageBackground];
        [self addSubview:self.textLabel];
    }
    return self;
}

// 单纯的label
- (id)initWithPureLabelFrame:(CGRect)frame TextColor:(UIColor *)textColor background:(UIColor *)backgroundColor font:(CGFloat )font
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.backgroundColor = backgroundColor.CGColor;
        //self.layer.cornerRadius = 5.0f;
        _textLabel = [[UILabel alloc] initWithFrame:frame];
        [_textLabel setFont:[UIFont systemFontOfSize:font]];
        self.textLabel.textColor = textColor;
        self.duration = DEFAULT_DURATION;
        [self addSubview:self.textLabel];
    }
    return self;
}

-(void)setType:(TipsUtilType)type{
    if(TipsUtilTypeWarrning == type){
        
    }else if(TipsUtilTypeSuccess == type){
        
    }else if(TipsUtilTypeNoBackground ==  type)
    {
        self.imageBackground.image = [UIImage createImageWithColor:[UIColor clearColor]];
        self.layer.opacity = 0.25;
    }
}

-(instancetype)initWithController:(UIViewController *)controller text:(NSString *)text{
    if([self initWithFrame:CGRectMake(0, -DEFAULT_HEIGHT, controller.view.bounds.size.width, DEFAULT_HEIGHT)]){
        self.text = text;
        self.controller = controller;
        self.textLabel.text = text;
        
        [self.textLabel sizeToFit];
        
        CGFloat textLabelCenterY;
        if ([UIApplication sharedApplication].statusBarHidden) {
            textLabelCenterY = DEFAULT_HEIGHT / 2;
        }
        else
        {
            textLabelCenterY = (DEFAULT_HEIGHT + 20) / 2;
        }
        self.textLabel.center = CGPointMake(controller.view.bounds.size.width/2,textLabelCenterY);// 20为statusBar的高度
        self.center = CGPointMake(self.controller.view.bounds.size.width/2,self.center.y);
    }
    return self;
}

-(instancetype)initWithText:(NSString *)text{
    if ([self initWithFrame:CGRectMake(0, -DEFAULT_HEIGHT, SCREEN_W, DEFAULT_HEIGHT)]) {
        self.text = text;
        self.textLabel.text = text;
        
        [self.textLabel sizeToFit];
        
        CGFloat textLabelCenterY;
        if ([UIApplication sharedApplication].statusBarHidden) {
            textLabelCenterY = DEFAULT_HEIGHT / 2;
        }
        else
        {
            textLabelCenterY = (DEFAULT_HEIGHT + 20) / 2;// 20为statusBar的高度
        }
        self.textLabel.center = CGPointMake(SCREEN_W/2,textLabelCenterY);
        self.center = CGPointMake(SCREEN_W/2,self.center.y);
    }
    
    return self;
}

-(instancetype)initUpWithText:(NSString *)text{

    if ([self initWithPureLabelFrame:CGRectMake(0, SCREEN_H, SCREEN_W, DEFAULT_UP_HEIGHT) TextColor:[UIColor whiteColor] background:RGB16(0xeb2d39) font:14]) {
        self.text = text;
        self.textLabel.text = text;
        
        [self.textLabel sizeToFit];
        
        CGFloat textLabelCenterY;
        textLabelCenterY = DEFAULT_UP_HEIGHT / 2;
        self.textLabel.center = CGPointMake(SCREEN_W/2,textLabelCenterY);
        self.center = CGPointMake(SCREEN_W/2,self.center.y);
    }
    
    return self;
}


-(void)showWithAnimation:(BOOL)animation{
    CGRect frame = self.frame;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    frame.origin.y = -DEFAULT_SPACE_IMG_TEXT;
    if(animation){
        [UIView animateWithDuration:DEFAULT_ANIMATON_DURATION animations:^{
            self.frame = frame;
        } completion:^(BOOL finished) {
            [self showHandle];
        }];
    }else{
        self.frame = frame;
        [self showHandle];
    }
}

-(void)showHandle{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DEFAULT_DURATION * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissWithAnimation:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    });
}

-(void)dismissWithAnimation:(BOOL)animation{
    CGRect frame = self.frame;
    frame.origin.y = -DEFAULT_HEIGHT;
    if(animation){
        [UIView animateWithDuration:DEFAULT_ANIMATON_DURATION animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [self removeFromSuperview];
    }
}

-(void)showUpWithAnimation:(BOOL)animation{
    CGRect frame = self.frame;
    frame.origin.y -= self.frame.size.height;
    if(animation){
        [UIView animateWithDuration:DEFAULT_ANIMATON_DURATION animations:^{
            self.frame = frame;
        } completion:^(BOOL finished) {
            [self showUpHandle];
        }];
    }else{
        self.frame = frame;
        [self showUpHandle];
    }
}

-(void)showUpHandle{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * DEFAULT_DURATION * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissUpWithAnimation:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    });
}

-(void)dismissUpWithAnimation:(BOOL)animation{
    CGRect frame = self.frame;
    frame.origin.y += self.frame.size.height;
    if(animation){
        [UIView animateWithDuration:DEFAULT_ANIMATON_DURATION animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [self removeFromSuperview];
    }
}

+(void)showInController:(UIViewController *)controller withText:(NSString *)text{
    [self showInController:controller withText:text type:TipsUtilTypeWarrning];
}

+(void)showInController:(UIViewController *)controller withText:(NSString *)text type:(TipsUtilType)type{
    TipsUtil *tips = [[TipsUtil alloc] initWithController:controller text:text];
    
    [controller.view addSubview:tips];
    tips.type = type;
    [tips showWithAnimation:YES];
    
}

+(void)showWithText:(NSString *)text type:(TipsUtilType)type{
    TipsUtil *tips = [[TipsUtil alloc] initWithText:text];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:tips];
    tips.type = type;
    [tips showWithAnimation:YES];
    
}

+(void)showWithText:(NSString *)text
{
    [self showWithText:text type:TipsUtilTypeWarrning];
}

+(void)showUpWithText:(NSString *)text type:(TipsUtilType)type{
    TipsUtil *tips = [[TipsUtil alloc] initUpWithText:text];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:tips];
    tips.type = type;
    [tips showUpWithAnimation:YES];
    
}

+(void)showUpWithText:(NSString *)text
{
    [self showUpWithText:text type:TipsUtilTypeWarrning];
}
@end