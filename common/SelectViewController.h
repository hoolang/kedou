//
//  SelectGenderViewController.h
//  lovelive
//
//  Created by Circle on 15/12/4.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "BaseViewController.h"
@protocol SelectViewControllerDelegate <NSObject>
-(void)selectDidFinish:(NSIndexPath *)indexPath data:(NSDictionary *) selectDic;
@end

@interface SelectViewController : BaseViewController
@property (copy, nonatomic) NSString *content;
@property (weak, nonatomic) id<SelectViewControllerDelegate> delegate;
@property (copy, nonatomic) NSArray* dataList;
@property (assign, nonatomic) NSInteger selectedIndex;
@end
