//
//  MultiSelectViewController.m
//  lovelive
//
//  Created by Circle on 16/1/22.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import "MultiSelectViewController.h"
#import "SimpleCell.h"
#import "SimpleCellModel.h"
#import "LoginMgr.h"
#import "ThemeCategoriesModel.h"

@interface MultiSelectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (assign, nonatomic) NSInteger count;

@end

@implementation MultiSelectViewController
static NSString * const SimpleCellId = @"SimpleCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LLLangZmb(@"select_tag_view_title", "选择标签");
    _count = self.selectedList.count;
    for (ThemeCategoriesModel *selectedModel in self.selectedList) {
        for (ThemeCategoriesModel *datalModel in self.dataList) {
            if ([selectedModel.id isEqual:datalModel.id]) {
                datalModel.isSlected = true;
                continue;
            }
        }
    }
    [self setupTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupTable{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = LLColor(239, 239, 239);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SimpleCell class]) bundle:nil] forCellReuseIdentifier:SimpleCellId];
    [self.view addSubview:_tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[LangUtil langForKey:@"done"] style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    [self.tableView reloadData];
}

- (void)done
{
    [_selectedList removeAllObjects];
    BOOL flag = false;
    for (ThemeCategoriesModel *model in self.dataList) {
        if (model.isSlected) {
            [_selectedList addObject:model];
            flag = true;
        }
    }
    if (!flag) {
        [TipsUtil showWithText:[LangUtil langForKey:@"tip_min_select_count" tbl:ZMB]];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(multiSelectDidFinish:dataType:)]) {
        [self.delegate multiSelectDidFinish:_selectedList dataType:_dataType];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma -mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleCellId];
    if (cell == nil) {
        cell = [[SimpleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleCellId];
    }
    cell.arrowView.hidden = YES;
    cell.themeCategoriesModel = self.dataList[indexPath.row];
    if (cell.themeCategoriesModel.isSlected) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
        cell.accessoryView = view;
    }
    else
    {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check2"]];
        cell.accessoryView = view;
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ThemeCategoriesModel *model = self.dataList[indexPath.row];
    
    if (_maxCount != 0 && _count >= _maxCount && !model.isSlected) {
        [iToast tip:[NSString stringWithFormat:[LangUtil langForKey:@"tip_max_select_count" tbl:ZMB], _maxCount]];
        return;
    }
    
    model.isSlected = !model.isSlected;
    
    if (model.isSlected) {
        _count++;
    }
    else
    {
        _count--;
    }
    
    if (_count < 0) {
        _count = 0;
    }
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return COMMON_CELL_HEIGHT;
}

@end
