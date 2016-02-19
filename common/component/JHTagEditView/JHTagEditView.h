//
//  TagEditView.h
//  lovelive
//
//  Created by JiangHan on 15/12/24.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class JHTagEditView;

// 代理，仅仅实现当Tag数量超过限定时触发回调
@protocol JHTagEditViewDelegate <NSObject>
@optional
- (void)tagsReachLimit:(JHTagEditView *)tagEditView count:(int)count;
@end



@interface JHTagEditView : UIView<UITextViewDelegate>
{
    NSMutableArray<UILabel *> * tagControls;

    CGFloat lastestTextFieldX;
    CGFloat lastestTextFieldY;
    UILabel * lastLabel;
    UITextView * inputTextControl;
    
    UILabel * selLabel;
    
    //id <TagEditViewDelegate> delegate;
}
@property (nonatomic, retain) id <JHTagEditViewDelegate> delegate;

@property(nonatomic,assign) CGFloat marginRight;            // 容器区域的右边距
@property(nonatomic,assign) CGFloat marginLeft;             // 容器区域的左边距
@property(nonatomic,assign) CGFloat marginTop;              // 容器区域的上边距
@property(nonatomic,assign) CGFloat marginBottom;           // 容器区域的下边距

@property(nonatomic,assign) CGFloat tagMaxText;             // 最大标签文本内容长度
@property(nonatomic,assign) CGFloat tagHeight;              // 标签高
@property(nonatomic,assign) CGFloat tagMaxWidth;            // 最大标签宽度
@property(nonatomic,assign) CGFloat tagFontSize;            // 标签字体尺寸

@property(nonatomic,assign) CGFloat tagYSpan;               // 行间距
@property(nonatomic,assign) CGFloat tagXSpan;               // 标签之间横向间距

@property(nonatomic,copy) UIColor * tagBackColor;           // 标签背景颜色
@property(nonatomic,copy) UIColor * tagBorderColor;         // 标签边框颜色
@property(nonatomic,assign) CGFloat tagBorderLineWidth;     // 标签边框线宽度

@property(nonatomic,copy) UIColor * borderColor;            // 控件边框颜色
@property(nonatomic,copy) UIColor * backColor;              // 控件背景颜色
@property(nonatomic,assign) CGFloat borderLineWidth;        // 控件边框线宽度

@property(nonatomic,assign) NSInteger maxTags;              // 最大的标签个数
@property(nonatomic,copy) UIColor *textColor;               // 文字颜色


- (void)settag:(NSString*)sender;
- (instancetype)initWithFrame:(CGRect)rect;
- (void) begin;
- (NSMutableArray *)getTags;
- (void)addTag:(NSString *)text;
@end


