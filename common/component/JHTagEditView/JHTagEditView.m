//
//  TagEditView.m
//  lovelive
//
//  Created by JiangHan on 15/12/24.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "JHTagEditView.h"

@interface JHTagEditView ()
@end

@implementation JHTagEditView

- (instancetype)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        _marginRight = 5;
        _marginLeft = 5;
        _marginTop = 5;
        _marginBottom = 5;
        
        _tagXSpan = 3;
        _tagYSpan = 3;
        
        _tagHeight = 25;
        _tagFontSize = 20;
        _tagMaxWidth = 300;
        _tagMaxText = -1;
        
        _maxTags = -1;
        
        _tagBackColor = [[UIColor alloc] initWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
        _tagBorderColor = [[UIColor alloc] initWithRed:0.0f/255.0f green:0.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
        _tagBorderLineWidth = 0.5f;
        
        _backColor = [[UIColor alloc] initWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
        _borderColor = [[UIColor alloc] initWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
        _borderLineWidth = 0.5f;

        tagControls = [[NSMutableArray alloc]init];
        inputTextControl = nil;
        lastestTextFieldX = _marginLeft;
        lastestTextFieldY = _marginTop;
        lastLabel = nil;

        _delegate = nil;
    }
    return self;
}

-(void) begin
{
    // 绘制控件边界
    [self setupView];
    
    // 增加第一个tf
    [self nextInputControl];
}

-(void) setupView
{
    UILabel * margin = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    margin.layer.borderColor = _borderColor.CGColor;
    margin.layer.borderWidth = _borderLineWidth;
    margin.layer.backgroundColor = _backColor.CGColor;
    
    [self addSubview:margin];
}

-(void) nextInputControl
{
    CGFloat x,y;
    
    if (lastLabel != nil)
        x = lastestTextFieldX + lastLabel.frame.size.width + _tagXSpan;
    else
        x = _marginLeft;
    
    y = lastestTextFieldY;
    
    if( x + 10 > self.frame.size.width - _marginRight )
    {
        // 换行
        x = _marginLeft;
        y += _tagHeight + _tagYSpan;
    }
    
    if( y + _tagHeight > self.frame.size.height - _marginBottom )
    {
        return;
    }
    
    if(inputTextControl == nil )
    {
        inputTextControl = [[UITextView alloc] initWithFrame:CGRectMake(x, y, _tagFontSize+5, _tagHeight)];
        //inputTextControl = [[UITextView alloc] initWithFrame:CGRectMake(x, y, _tagFontSize*20, _tagHeight)];
        
        inputTextControl.text = @"";
        inputTextControl.font = [UIFont systemFontOfSize:_tagFontSize];
        inputTextControl.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        inputTextControl.textColor=_textColor;
        inputTextControl.delegate = self;
        inputTextControl.backgroundColor = [UIColor clearColor];
        
        inputTextControl.returnKeyType = UIReturnKeyDone;
        [self addSubview:inputTextControl];
    }
    else
    {
        inputTextControl.frame = CGRectMake(x, y, _tagFontSize+5, _tagHeight);
        inputTextControl.text = @"";
    }
    
    lastestTextFieldX = x;
    lastestTextFieldY = y;
    
    // 设置输入焦点
    //[inputTextControl becomeFirstResponder];
}

- (void)doDeleteBack {
    
    // 删除上一个标签
    if( lastLabel )
    {
        lastestTextFieldX = lastLabel.frame.origin.x;
        lastestTextFieldY = lastLabel.frame.origin.y;
        
        CGRect rect = CGRectMake(lastLabel.frame.origin.x, lastLabel.frame.origin.y, 0, 0);
        rect.size.width = inputTextControl.frame.size.width;
        rect.size.height = inputTextControl.frame.size.height;
        
        inputTextControl.frame = rect;
        
        [lastLabel removeFromSuperview];
        [tagControls removeObject:lastLabel];

        lastLabel = [tagControls lastObject];
    }
    [_delegate tagsReachLimit:self count:(int)[tagControls count]];
}

/*由于联想输入的时候，函数textView:shouldChangeTextInRange:replacementText:无法判断字数，
 因此使用textViewDidChange对TextView里面的字数进行判断
 */
- (void)textViewDidChange:(UITextView *)textView
{
    //该判断用于联想输入
    if (_tagMaxText>0 && textView.text.length > _tagMaxText)
    {
        textView.text = [textView.text substringToIndex:_tagMaxText];
    }
    
    textView.frame=CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width+_tagFontSize*10, textView.frame.size.height);
    
    [textView sizeToFit];
    
    while( textView.frame.size.width > self.frame.size.width - _marginRight - _marginLeft - 6 )
    {
        // 太长了，超过一行显示
        int count = (int)[textView.text length];
        textView.text = [textView.text substringToIndex:count-1];
        [textView sizeToFit];
    }
    
    if( textView.frame.origin.x + textView.frame.size.width > self.frame.size.width - _marginRight )
    {
        if( textView.frame.origin.y + _tagHeight + _marginBottom < self.frame.size.height )
        {
            // 换行先
            lastestTextFieldX = _marginLeft;
            lastestTextFieldY = lastestTextFieldY + _tagHeight + _tagYSpan;
            
            textView.frame=CGRectMake(lastestTextFieldX, lastestTextFieldY, textView.frame.size.width, textView.frame.size.height);
        }
    }
}

// --- TextViewDelegate method

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    
    
    if( [text isEqualToString:@"\n"] )
    {
        // 收到了回车键，我们需要完成一个标签
        if ((int)[[self getTags] count]==_maxTags) {
            return NO;
        }
        [textView sizeToFit];
        [self doReturn];
        return NO;
    }
    else if( [text isEqualToString:@""] )
    {
        // 收到了清除键，我们需要判断，如果当前输入框为空，则删除上一个标签
        if( [textView.text length] == 0 )
        {
            [self doDeleteBack];
            return NO;
        }
    }
    else if( [text isEqualToString:@" "] )
    {
        // 收到了空格键，我们需要判断，如果当前输入框为空，则删除上一个标签
        if ((int)[[self getTags] count]==_maxTags) {
            return NO;
        }
        [textView sizeToFit];
        [self doReturn];
        return NO;
    }
    else{
        if ((int)[[self getTags] count]==_maxTags) {
            return NO;
        }
    }
    
    // 调整textView大小，适应内容
    [textView sizeToFit];
    
    if( [text isEqualToString:@""] == NO )
    {
        // 不是清除键，那么就是要增加内容了，下面需要判断限制条件
        
        if( textView.frame.size.width+_tagFontSize+2 > self.frame.size.width - _marginLeft -_marginRight - 6 )
        {
            // 达到了最大标签宽度,再宽就要超过一行了
            return NO;
        }
        
        if( _tagMaxText>0 && [[textView text] length] >= _tagMaxText )
        {
            // 达到了设定的最大标签文字内容长度，也不准再输入了
            return NO;
        }
    }
    
    textView.frame=CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width+_tagFontSize*5, textView.frame.size.height);
    
    return YES;
}

-(BOOL)doReturn{
    
    if( [inputTextControl.text length] == 0 )
    {
        // 如果当前还没有输入任何东西，那么不能构成标签
        return NO;
    }
    
    
    
    if( _maxTags>0 && [tagControls count] >= _maxTags )
    {
        if( _delegate != nil )
            [_delegate tagsReachLimit:self count:(int)[tagControls count]];
        return NO;
    }
    
    CGRect currentRect = inputTextControl.frame;
    if( currentRect.size.width + lastestTextFieldX > self.frame.size.width - _marginLeft - _marginRight - 4 )
    {
        // 换行
        CGFloat x, y;
        
        x = _marginLeft;
        y = lastestTextFieldY + _tagHeight + _tagYSpan;
        
        if( y + _tagHeight + _tagYSpan > self.frame.size.height - _marginBottom )
        {
            return NO;
        }
        
        lastestTextFieldX = x;
        lastestTextFieldY = y;
        
        inputTextControl.frame = CGRectMake(x, y, currentRect.size.width, currentRect.size.height);
    }
    
    // 完成后禁止用户继续输入
    
    UILabel * newLabel = [[UILabel alloc] initWithFrame:CGRectMake(inputTextControl.frame.origin.x, inputTextControl.frame.origin.y, inputTextControl.frame.size.width, _tagFontSize+2)];
    newLabel.layer.cornerRadius=newLabel.frame.size.height*0.5;
    [newLabel setText:inputTextControl.text];
    newLabel.textColor=_textColor;
    [self addSubview:newLabel];
    [tagControls addObject:newLabel];
    
    
    
    newLabel.layer.borderColor = _tagBorderColor.CGColor;
    newLabel.layer.backgroundColor = _tagBackColor.CGColor;
    newLabel.layer.borderWidth = _tagBorderLineWidth;
    newLabel.textAlignment = NSTextAlignmentCenter;
    newLabel.font = inputTextControl.font;
    
    lastLabel = newLabel;
    
    [self reRange:YES];
    
    // 新增一个新的textField
    //[self nextInputControl];
    [_delegate tagsReachLimit:self count:(int)[tagControls count]];
    return YES;
}


- (void)settag:(NSString*)sender{
    //inputTextControl.text=sender;
    //[inputTextControl sizeToFit];
    CGSize size =[sender sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    UILabel * newLabel = [[UILabel alloc] initWithFrame:CGRectMake(inputTextControl.frame.origin.x, inputTextControl.frame.origin.y, size.width, _tagFontSize+2)];
    newLabel.layer.cornerRadius=newLabel.frame.size.height*0.5;
    [newLabel setText:sender];
    newLabel.textColor=_textColor;
    [self addSubview:newLabel];
    [tagControls addObject:newLabel];
    
    
    newLabel.layer.borderColor = _tagBorderColor.CGColor;
    newLabel.layer.backgroundColor = _tagBackColor.CGColor;
    newLabel.layer.borderWidth = _tagBorderLineWidth;
    newLabel.textAlignment = NSTextAlignmentCenter;
    newLabel.font = inputTextControl.font;
    
    lastLabel = newLabel;
    
    [self reRange:YES];
    
    // 新增一个新的textField
    //[self nextInputControl];
    [_delegate tagsReachLimit:self count:(int)[tagControls count]];
}

-(void)reRange:(BOOL)clearInput
{
    lastestTextFieldX = _marginLeft;
    lastestTextFieldY = _marginTop;
    lastLabel = nil;
    
    if(clearInput)
    {
        inputTextControl.frame = CGRectMake(inputTextControl.frame.origin.x, inputTextControl.frame.origin.y, _tagFontSize+5, _tagHeight);
        inputTextControl.text = @"";
        [inputTextControl sizeToFit];
    }
    
    int k = 0;
    int count = (int)[tagControls count];
    for( k=0; k<count; k++ )
    {
        UILabel * label = tagControls[k];
        if( label != nil )
        {
            if( lastestTextFieldX + label.frame.size.width < self.frame.size.width - _marginRight )
            {
                label.frame = CGRectMake(lastestTextFieldX, lastestTextFieldY, label.frame.size.width, label.frame.size.height );
            }
            else
            {
                lastestTextFieldX = _marginLeft;
                lastestTextFieldY = lastestTextFieldY + _tagHeight + _tagYSpan;
                label.frame = CGRectMake(lastestTextFieldX, lastestTextFieldY, label.frame.size.width, label.frame.size.height );
            }
            
            lastestTextFieldX = label.frame.origin.x + label.frame.size.width + _tagXSpan;
            lastestTextFieldY = label.frame.origin.y;
            if( lastestTextFieldX + 10 >= self.frame.size.width - _marginRight )
            {
                lastestTextFieldX = _marginLeft;
                lastestTextFieldY += _tagHeight + _tagYSpan;
            }

            lastLabel = label;
        }
    }
    
    if(lastestTextFieldX + inputTextControl.frame.size.width < self.frame.size.width - _marginRight )
    {
        inputTextControl.frame = CGRectMake(lastestTextFieldX, lastestTextFieldY, inputTextControl.frame.size.width, inputTextControl.frame.size.height );
    }
    else
    {
        lastestTextFieldX = _marginLeft;
        lastestTextFieldY = lastestTextFieldY + _tagHeight + _tagYSpan;
        inputTextControl.frame = CGRectMake(lastestTextFieldX, lastestTextFieldY, inputTextControl.frame.size.width, inputTextControl.frame.size.height );
    }
    
    [inputTextControl becomeFirstResponder];
}

- (void)addTag:(NSString *)text
{
    if( [tagControls count] >= _maxTags )
    {
        [_delegate tagsReachLimit:self count:(int)[tagControls count]];
        return;
    }
    
    CGRect rect=CGRectMake(0, 0, _tagFontSize*([text length]+5), _tagHeight);
    
    UILabel * newLabel = [[UILabel alloc] initWithFrame:rect];
    newLabel.layer.cornerRadius=newLabel.frame.size.height*0.5;
    [newLabel setText:text];
    [newLabel sizeToFit];
    newLabel.frame = CGRectMake(newLabel.frame.origin.x, newLabel.frame.origin.y, newLabel.frame.size.width+10, newLabel.frame.size.height);
    newLabel.textColor=_textColor;
    [self addSubview:newLabel];
    [tagControls addObject:newLabel];
    
    newLabel.layer.borderColor = _tagBorderColor.CGColor;
    newLabel.layer.backgroundColor = _tagBackColor.CGColor;
    newLabel.layer.borderWidth = _tagBorderLineWidth;
    newLabel.textAlignment = NSTextAlignmentCenter;
    newLabel.font = inputTextControl.font;
    
    lastLabel = newLabel;
    
    [self reRange:YES];
    return;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch=[touches anyObject];
    CGPoint fingerPoint=[touch locationInView:self];
    
    int k = 0;
    int count = (int)[tagControls count];
    
    for( k=0; k<count; k++ )
    {
        UILabel * label = tagControls[k];
        if( label )
        {
            BOOL contains = CGRectContainsPoint(label.frame, fingerPoint);
            if( contains )
            {
                selLabel = label;
            }
        }
    }
    
    if( inputTextControl != nil )
        [inputTextControl becomeFirstResponder];
    
    NSLog(@"touches end");
}

//手指移动时候发出
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

}

//当手指离开屏幕时候
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch=[touches anyObject];
    CGPoint fingerPoint=[touch locationInView:self];
    
    int k = 0;
    int count = (int)[tagControls count];
    
    for( k=0; k<count; k++ )
    {
        UILabel * label = tagControls[k];
        if( label )
        {
            BOOL contains = CGRectContainsPoint(label.frame, fingerPoint);
            if( contains )
            {
                if( label == selLabel )
                {
                    // 要清除掉这个label;
                    [tagControls removeObject:label];
                    [label removeFromSuperview];
                    label = nil;
                    
                    [self reRange:NO];
                    break;
                }
            }
        }
    }

    NSLog(@"touches end");
}


- (NSMutableArray *)getTags
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    int k = 0;
    int count = (int)[tagControls count];
    
    for( k=0; k<count; k++ )
    {
        UILabel * label = tagControls[k];
        if( label )
        {
            NSString * txt = label.text;
            if( txt && [txt length] > 0 )
            {
                [array addObject:[NSString stringWithFormat:@"%@",txt]];
            }
        }
    }
    return array;
}

// ----------------------- getter/setter --------------------------
-(void) setTagFontSize:(CGFloat) size
{
    _tagFontSize = size;
    if( _tagHeight < size + 5 )
        _tagHeight = size + 5;
}

@end
