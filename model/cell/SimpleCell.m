//
//  SimpleCell.m
//  lovelive
//
//  Created by Circle on 15/11/26.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "SimpleCell.h"
#import "LocalModel.h"
#import "SimpleCellModel.h"

@implementation SimpleCell

- (id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"SimpleCell" owner:self options:nil] lastObject];
    if(self){
        //选中背景不发生改变
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.checkBtn setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)awakeFromNib
{
    self.bottomLineHeight.constant = 0.5;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setLocalModel:(LocalModel *)localModel{
    _localModel = localModel;
    if (_isChinese) {
        _cellLabel.text = localModel.name;
    }else _cellLabel.text = localModel.code;
    
}

- (void)setAreaCodeModel:(LocalModel *)areaCodeModel{
    _areaCodeModel = areaCodeModel;
    if (_isChinese) {
        _cellLabel.text = areaCodeModel.name;
    }else _cellLabel.text = areaCodeModel.code;
    _cellText.text = [NSString stringWithFormat:@"+%@", areaCodeModel.areanumber];
}


- (void)setSimpleCellModel:(SimpleCellModel *)simpleCellModel{
    _simpleCellModel = simpleCellModel;
    
    if (simpleCellModel.leftText) {
        _cellLabel.text = simpleCellModel.leftText;
    }else{
        _cellLabel.text = @"";
    }
    
    if (simpleCellModel.rightText) {
        _cellText.text = simpleCellModel.rightText;
    }else{
        _cellText.text = @"";
    }
    
    if (simpleCellModel.showImgView) {
        _statusImgView.hidden = NO;
        _cellText.hidden = YES;
    }else{
        _statusImgView.hidden = YES;
    }
    
}

- (void)setThemeCategoriesModel:(ThemeCategoriesModel *)themeCategoriesModel{
    _themeCategoriesModel = themeCategoriesModel;
    
    if (_themeCategoriesModel.name) {
        _cellLabel.text = themeCategoriesModel.name;
    }else{
        _cellLabel.text = @"";
    }
    
    _cellText.hidden = YES;
}

@end
