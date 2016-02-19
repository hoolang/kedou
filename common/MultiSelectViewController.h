//
//  MultiSelectViewController.h
//  lovelive
//
//  Created by Circle on 16/1/22.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "BaseViewController.h"
@protocol MultiSelectViewControllerDelegate <NSObject>
-(void)multiSelectDidFinish:(NSMutableArray *)selectedResult dataType:(NSInteger)dataType;
@end

@interface MultiSelectViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *courses;
@property (strong, nonatomic) NSMutableArray *selectedList; //已选中
@property (strong, nonatomic) NSMutableArray *dataList; //数据源
@property (assign, nonatomic) int maxCount; //最大选择数量
@property (assign, nonatomic) NSInteger dataType; //数据类型 用于一个界面调用多种数据：如选择标签和选择教育方向；
@property (weak, nonatomic) id<MultiSelectViewControllerDelegate> delegate;
@end
