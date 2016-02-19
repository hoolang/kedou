//
//  CountryListViewController.m
//  lovelive
//
//  Created by Circle on 15/11/27.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "CountryListViewController.h"
#import "SimpleCell.h"
#import "LocalModel.h"
#import "LocalMgr.h"

@interface CountryListViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    BOOL isChinese;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *countries;
@end

@implementation CountryListViewController

static NSString * const SimpleCellId = @"SimpleCell";

-(NSArray *)countries{
    
    if (_countries == nil) {
        _countries = [[LocalMgr sharedInstance] countryList];
    }
    return _countries;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isChinese = [LangUtil isChinese];
    
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setTintColor:RGB16(COLOR_BG_ORANGE)];
    [mySearchBar setPlaceholder:LLLangZmb(@"country_list_search", "搜索")];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    [searchDisplayController.searchBar setBackgroundImage:[UIImage createImageWithColor:RGB16(COLOR_BG_GRAY)]];
    
    self.tableView.tableHeaderView = mySearchBar;
    if (!_listStyle) {
        _listStyle = COUNTRY_NAME;
    }

    [self setupTable];
}

- (void)setupTable{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SimpleCell class]) bundle:nil] forCellReuseIdentifier:SimpleCellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SimpleCell class]) bundle:nil] forCellReuseIdentifier:SimpleCellId];
    [self.searchDisplayController.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.dsf
}

#pragma -mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    }else return self.countries.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleCellId];
    cell.isChinese = isChinese;

    if (_listStyle == COUNTRY_AREA_CODE) {
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            cell.areaCodeModel = searchResults[indexPath.row];
        }
        else
        {
            cell.areaCodeModel = self.countries[indexPath.row];
        }
        
        if (cell.areaCodeModel.areanumber == nil || [cell.areaCodeModel.areanumber isEqual:@""]) {
            cell.cellLabel.text = @"";
            cell.cellText.text = @"";
            cell.arrowView.hidden = YES;
            
        }else
        {
            cell.arrowView.hidden = NO;
        }
    }else
    {
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            cell.localModel = searchResults[indexPath.row];
        }
        else
        {
            cell.localModel = self.countries[indexPath.row];
        }
        
        cell.cellText.hidden = YES;
    }
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.1;
//}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    UIButton *cancelBtn = [searchBar valueForKey:@"_cancelButton"];
    if (cancelBtn) {
        [cancelBtn setTitle:LLLangZmb(@"cancel", @"取消") forState:UIControlStateNormal];
    }
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(countryListDidSelected:)]) {
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            [self.delegate countryListDidSelected:searchResults[indexPath.row]];
        }
        else
        {
            [self.delegate countryListDidSelected:self.countries[indexPath.row]];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_listStyle == COUNTRY_AREA_CODE) {
        LocalModel *model = [[LocalModel alloc] init];
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            model = searchResults[indexPath.row];
        }
        else
        {
            model = self.countries[indexPath.row];
        }
        if (model.areanumber == nil || [model.areanumber isEqual:@""]) {
            return 0.00;
        }
    }
    
    return 50;
}

#pragma UISearchDisplayDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchResults = [[NSMutableArray alloc]init];
    LLLog(@"searchText %@", searchText);
    searchText = [searchText lowercaseString];
    for (LocalModel *model in self.countries) {
        NSRange range;
        if (isChinese) {
            range = [model.name rangeOfString:searchText];
        }else{
            range = [[model.code lowercaseString] rangeOfString:searchText];
        }
        if (range.location != NSNotFound) {
            [searchResults addObject:model];
        }
    }
    
    if (searchResults.count == 0) {
        UILabel *noResultsLabel = [searchDisplayController valueForKey:@"_noResultsLabel"];
        [noResultsLabel setText:LLLangZmb(@"no_result", @"无结果")];
    }
}
@end
