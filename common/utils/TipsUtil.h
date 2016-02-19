//
//  TipsUtil.h
//  lovelive
//
//  Created by Circle on 16/1/8.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    TipsUtilTypeWarrning = 0,       // 暂时没效果
    TipsUtilTypeSuccess = 1,        // 暂时没效果
    TipsUtilTypeNoBackground,       // 没有背景图片， 默认背景位黑色，透明度位0.25。 TODO：现在只是重置背景图片为透明，性能不太好。应改为不用图片背景，直接用label显示。
}TipsUtilType;
@interface TipsUtil : UIView

-(instancetype)initWithController:(UIViewController *)controller text:(NSString *)text;
/**
 *  停留时间
 */
@property (nonatomic,assign) NSTimeInterval duration;
@property(nonatomic,assign) TipsUtilType type;
-(void)showWithAnimation:(BOOL)animation;
-(void)dismissWithAnimation:(BOOL)animation;

+(void)showWithText:(NSString *)text type:(TipsUtilType)type;

+(void)showWithText:(NSString *)text;

+(void)showInController:(UIViewController *)controller withText:(NSString *)text type:(TipsUtilType)type;

+(void)showInController:(UIViewController *)controller withText:(NSString *)text;

+(void)showUpWithText:(NSString *)text;
+(void)showUpWithText:(NSString *)text type:(TipsUtilType)type;
@end
