//
//  SelectGenderViewController.m
//  lovelive
//
//  Created by Circle on 15/12/4.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *accessoryView;
@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupTable{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.frame = CGRectMake (0,64,self.view.frame.size.width,self.view.bounds.size.height);
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = LLColor(239, 239, 239);
    
    // 设置cell的边框颜色
//    [_tableView setSeparatorColor:[UIColor clearColor]];
//    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:_tableView];
    
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
    _accessoryView = view;
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[LangUtil langForKey:@"done"] style:UIBarButtonItemStylePlain target:self action:@selector(done)];
}

- (void)done
{
//    if ([self.delegate respondsToSelector:@selector(selectDidFinish:)]) {
//        [self.delegate selectDidFinish:_content];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_W, 0.5)];
        [bottomLine setBackgroundColor:RGB16(COLOR_BG_COMM)];
        [cell addSubview:bottomLine];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = RGB16(COLOR_CELL);
    }
    
    NSDictionary* cellData = [self.dataList objectAtIndex:indexPath.row];
    if (cellData) {
        if (cellData[@"title"]) {
            cell.textLabel.text = cellData[@"title"];
        }
    }
    if (indexPath.row == self.selectedIndex) {
        cell.accessoryView = _accessoryView;
    }else{
        cell.accessoryView = nil;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* cellData = [self.dataList objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectDidFinish:data:)]) {
        [self.delegate selectDidFinish:indexPath data:cellData];
    }
    [self.navigationController popViewControllerAnimated:YES];
//    self.selectedIndex = indexPath.row;
}
@end
