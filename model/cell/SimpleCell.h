//
//  SimpleCell.h
//  lovelive
//
//  Created by Circle on 15/11/26.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocalModel;
@class SimpleCellModel;
@class ThemeCategoriesModel;
@interface SimpleCell : UITableViewCell
@property (assign, nonatomic) BOOL isChinese;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellText;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgView;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrowViewAndRightBorder;
@property (strong, nonatomic) LocalModel *localModel;
@property (strong, nonatomic) LocalModel *areaCodeModel;
@property (strong, nonatomic) SimpleCellModel *simpleCellModel;
@property (strong, nonatomic) ThemeCategoriesModel *themeCategoriesModel;
@end