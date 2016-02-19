//
//  LocalViewController.m
//  lovelive
//
//  Created by Circle on 15/11/26.
//  Copyright © 2015年 LoveOrange. All rights reserved.
//

#import "LocalViewController.h"
#import "CountryListViewController.h"
#import "SimpleCell.h"
#import "SimpleCellModel.h"
#import "LocalModel.h"
#import "NowLocalModel.h"
#import "LLToolBar.h"
@interface LocalViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIPickerViewDataSource,
UIPickerViewDelegate,
UITextFieldDelegate,
CountryListViewDelegate,
LLToolBarDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *cellDetails;
@property (strong, nonatomic) NSString *selectCountryCode;
@property (strong, nonatomic) NSArray *provinces;
@property (assign, nonatomic) NSInteger provinceIndex;
@property (assign, nonatomic) NSInteger cityIndex;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (assign, nonatomic) NSInteger num;

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) LLToolBar *toolBar;
@property (assign, nonatomic) BOOL firtsLoad;

@end

@implementation LocalViewController
{
    SimpleCellModel *simpleModel;
    SimpleCellModel *simpleModel1;
    SimpleCellModel *simpleModel2;
    BOOL isChinese;
}

static NSString * const SimpleCellId = @"SimpleCell";

- (NSMutableArray *)cellDetails{
    if (_cellDetails == nil) {
        _cellDetails = [NSMutableArray array];
        
        simpleModel = [[SimpleCellModel alloc] init];
        simpleModel.leftText = [LangUtil langForKey:@"location"];
        simpleModel.rightText = [LangUtil langForKey:@"localLimitTitle"];
        
        simpleModel1 = [[SimpleCellModel alloc] init];
        simpleModel1.leftText = [LangUtil langForKey:@"nationLabel"];
        simpleModel1.rightText = (self.nationText.length > 0) ? self.nationText :[LangUtil langForKey:@"nationText"];

        simpleModel2 = [[SimpleCellModel alloc] init];
        
        if (self.provinceText.length > 0 && self.cityText.length > 0) {
            simpleModel2.leftText  = [NSString stringWithFormat:@"%@-%@", self.provinceText, self.cityText];
        }else if (self.provinceText.length > 0 && self.cityText.length == 0) {
            simpleModel2.leftText  = self.provinceText;
        }else if (self.cityText.length > 0)
        {
            simpleModel2.leftText  = self.cityText;
        }else{
            simpleModel2.leftText = [LangUtil langForKey:@"provinceLabel"];
        }
        
        if (_localType == LOCAL_NEED_ADDITION) {
            [_cellDetails addObject:simpleModel];
        }
        [_cellDetails addObject:simpleModel1];
        [_cellDetails addObject:simpleModel2];
    }
    return _cellDetails;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isChinese = [LangUtil isChinese];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[LangUtil langForKey:@"done"] style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    
    self.tableView.backgroundColor = RGB16(0xf3f3f3);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SimpleCell class]) bundle:nil] forCellReuseIdentifier:SimpleCellId];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(-10, 0, 1, 45)];
    self.textField.delegate = self;
    
    _toolBar = [[LLToolBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 40.0f)];
    _toolBar.llToolBarDelegate = self;
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.frame = CGRectMake(0, SCREEN_H - 216, SCREEN_W, 216);
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
   
    self.textField.inputAccessoryView = _toolBar;
    self.textField.inputView = self.pickerView;
    
    [self.view addSubview:_textField];
    
    _num = 2;
    [self setupData];
    //[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doFinish
{
    if (self.provinceIndex == 0) {
        LocalModel *province = self.provinces[0];
        [self selectData:province];
        
    }
    
    [self.textField resignFirstResponder];
}

- (void)setupData{
    _firtsLoad = YES;
    if (_nation !=nil && ![_nation isEqual:@""]) {
        
        LocalModel *localModel = [[LocalMgr sharedInstance] oneCountryData:_nation];
        NSString *nationTmp = self.nation;
        NSString *provinceTmp = self.province;
        NSString *cityTmp = self.city;
        [self countryListDidSelected:localModel];
        
        self.nation = nationTmp;
        self.province = provinceTmp;
        self.city = cityTmp;
        
        SimpleCellModel *cellModel2 = simpleModel2;
        cellModel2.leftText = [LangUtil langForKey:@"provinceLabel"];
        
        if ([_provinceText isEqual:@""] && [_cityText isEqual:@""] && _provinceText == nil && _cityText == nil)
        {
            cellModel2.rightText = [LangUtil langForKey:@"provinceText"];
        }
        else if(![_cityText isEqual:@""] && _provinceText != nil &&_cityText != nil)
        {
            cellModel2.rightText = [NSString stringWithFormat:@"%@-%@", _provinceText, _cityText];
        }
        else if(![_provinceText isEqual:@""] && _provinceText != nil )
        {
            cellModel2.rightText = _provinceText;
        }
        simpleModel2 = cellModel2;
    }
    _firtsLoad = NO;
}

- (void)selectData:(LocalModel *)province
{
    if (_num == 2) {
        
        self.province = province.code;
        
        NSDictionary *cityDic = province.localArray[0];
        self.city = cityDic[@"code"];
        
        SimpleCellModel *tmp = simpleModel2;
        if (isChinese) {
            _provinceText = province.name;
            _cityText = cityDic[@"name"];
        }else
        {
            _provinceText = province.code;
            _cityText = cityDic[@"code"];
        }
        
        //tmp.rightText = [_provinceText stringByAppendingString:[@"-" stringByAppendingString:_cityText]];
        
        if ([cityDic[@"code"] isEqual:@"Beijing"] || [cityDic[@"code"] isEqual:@"Chongqing"] || [cityDic[@"code"] isEqual:@"Tianjin"] || [cityDic[@"code"] isEqual:@"Hong Kong"] || [cityDic[@"code"] isEqual:@"Shanghai"] || [cityDic[@"code"] isEqual:@"Macau"]) {
            tmp.rightText = _provinceText;
            self.city = province.code;
        }
        else{
            tmp.rightText = [_provinceText stringByAppendingString:[@"-" stringByAppendingString:_cityText]];
        }
        
        simpleModel2 = tmp;
    }
    else{
        self.province = province.code;
        self.city = province.code;
        
        SimpleCellModel *tmp = simpleModel2;
        
        if (isChinese) {
            tmp.rightText = province.name;
            _provinceText = province.name;
        }
        else
        {
            tmp.rightText = province.code;
            _provinceText = province.code;
        }
        simpleModel2 = tmp;
    }
    
    //[self reloadOneCell:self.tableView row:1 inSection:0];
    [self.tableView reloadData];
}

- (void)done{
    if ([self.delegate respondsToSelector:@selector(localViewPickerResults:)]) {
        NowLocalModel *model = [[NowLocalModel alloc] init];
        
        model.nation = self.nation;
        model.province = self.province;
        model.city = self.city;
        model.nationText = self.nationText;
        model.provinceText = self.provinceText;
        model.cityText = self.cityText;
        
        [self.delegate localViewPickerResults:model];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleCellId];
    cell.simpleCellModel = self.cellDetails[indexPath.row];
    //cell.bottomLineHeight.constant = 0.5;
    //[cell.cellText setTextColor:RGB16(0x9F9F9F)];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_localType == LOCAL_NEED_ADDITION) {
        if (indexPath.row == 0) {
            self.nation = @"";
            self.province = @"";
            self.city = @"";
            
            self.nationText = @"";
            self.provinceText = @"";
            self.cityText = @"";
            
            [self done];
        }
        
        else if (indexPath.row == 1) {
            
            [_textField resignFirstResponder];
            CountryListViewController *vc = [[CountryListViewController alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self setupPickerData];
            LLLogFunc
            LLLog(@"self.provinceIndex %ld", self.provinceIndex);
            if (_num == 0) {
                return;
            }
            [self.pickerView reloadAllComponents];
            [self.textField becomeFirstResponder];
            
            [self.view reloadInputViews];
        }
    }else
    {
        if (indexPath.row == 0) {
            
            [_textField resignFirstResponder];
            CountryListViewController *vc = [[CountryListViewController alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            [self setupPickerData];
            LLLogFunc
            LLLog(@"self.provinceIndex %ld", self.provinceIndex);
            if (_num == 0) {
                return;
            }
            [self.pickerView reloadAllComponents];
            [self.textField becomeFirstResponder];
            
            [self.view reloadInputViews];
        }
    }
    
}

- (void) setupPickerData
{
    LLLogFunc
    LLLog(@"self.provinceIndex %ld", self.provinceIndex);
    if (self.provinces.count == 0) {
        _num = 0;
    }else if(self.provinces.count == 1){
        _num = 1;
        
        NSMutableArray *mArrary = [NSMutableArray array];
        LocalModel *cities = self.provinces[0];
        
        if (cities.localArray == nil || cities.localArray.count < 1) {
            return;
        }
        for (NSDictionary *dic in cities.localArray) {
            LocalModel *localModel = [[LocalModel alloc] init];
            localModel.name = dic[@"name"];
            if (isChinese) {
                localModel.name = dic[@"name"];
            }
            else
            {
                localModel.name = dic[@"code"];
            }
            localModel.code = dic[@"code"];
            [mArrary addObject:localModel];
        }
       
        self.provinces = mArrary;
    }
    
    LLLogFunc
    LLLog(@"self.provinceIndex %ld", self.provinceIndex);
}

#pragma mark
-(void) reloadOneCell:(UITableView *)tableView row:(int)row inSection:(int) section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - LLToolBarDelegate
- (void)clickTabBarLeftButton
{
    [_textField resignFirstResponder];
}

- (void)clickTabBarRightButton
{
    [self doFinish];
}

#pragma mark - CountryListViewDelegate
-(void)countryListDidSelected:(LocalModel *)results
{
    SimpleCellModel *scModel = simpleModel1;
    
    if (isChinese) {
        scModel.rightText = results.name;
        self.nationText = results.name;
    }
    else
    {
        scModel.rightText = results.code;
        self.nationText = results.code;
    }
    if (!_firtsLoad) {
        self.provinceText = nil;
        self.cityText = nil;
    }
    
    self.nation= results.code;
    self.province = results.code;
    self.city = results.code;
    self.provinces = results.localArray;
    
    NSMutableArray *mArrary = [NSMutableArray array];
    for (NSDictionary *dic in results.localArray) {
        LocalModel *localModel = [[LocalModel alloc] init];
        if (isChinese) {
            localModel.name = dic[@"name"];
        }
        else
        {
            localModel.name = dic[@"code"];
        }
        
        localModel.code = dic[@"code"];
        localModel.localArray = dic[@"city"];
        [mArrary addObject:localModel];
    }
    
    
    self.provinces = mArrary;
    simpleModel1 = scModel;
    
    SimpleCellModel *scModel2 = simpleModel2;
    scModel2.rightText = [LangUtil langForKey:@"provinceText"];
    simpleModel2 = scModel2;

    _num = 2;
    
    if (self.provinces.count == 0) {
        _num = 0;
        scModel2.rightText = @" -- ";
    }else if(self.provinces.count == 1){
        _num = 1;
    }
    
    [self.tableView reloadData];
    [self.pickerView reloadAllComponents];
    
    if (_num == 2) {
        [self.pickerView selectRow:0 inComponent:0 animated:YES];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
    }
    else if (_num == 1)
    {
        [self.pickerView selectRow:0 inComponent:0 animated:YES];
    }
    self.provinceIndex = 0;
    self.cityIndex = 0;
}

#pragma mark - PickerViewDelegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _num;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinces.count;
        
    }else{
        LocalModel *province = self.provinces[self.provinceIndex];
        return province.localArray.count;
    }

    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    //显示省份
    if (component == 0) {
        LocalModel *province = self.provinces[row];
        title = province.name;
        if (isChinese) {
            title = province.name;
        }
        else
        {
            title = province.code;
        }
        
    }else{//显示城市
        //默认是第一城市
        
        LocalModel *province = self.provinces[self.provinceIndex];
        NSDictionary *cityDic = province.localArray[row];
        
        
        if (isChinese) {
            title = cityDic[@"name"];
        }
        else
        {
            title = cityDic[@"code"];
        }
    }

    return title;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    //省份选中
    if (component == 0) {
        LocalModel *province = self.provinces[row];
        LLLog(@"选中省份 %@",province.name);
        //更改当前选中的省份索引
        self.provinceIndex = row;
        [self selectData:province];
        if(_num == 2)
        {
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
        }
        
    }else if(component == 1){
        if (_num == 2) {
            LocalModel *province = self.provinces[self.provinceIndex];
            self.province = province.code;
            NSDictionary *cityDic = province.localArray[row];
            self.city = cityDic[@"code"];
            
            if (isChinese) {
                _provinceText = province.name;
                _cityText = cityDic[@"name"];
            }
            else
            {
                _provinceText = province.code;
                _cityText = cityDic[@"code"];
            }
            SimpleCellModel *tmp = simpleModel2;
            if ([cityDic[@"code"] isEqual:@"Beijing"] || [cityDic[@"code"] isEqual:@"Chongqing"] || [cityDic[@"code"] isEqual:@"Tianjin"] || [cityDic[@"code"] isEqual:@"Hong Kong"] || [cityDic[@"code"] isEqual:@"Shanghai"] || [cityDic[@"code"] isEqual:@"Macau"]) {
                tmp.rightText = _provinceText;
                self.city = province.code;
            }
            else{
                tmp.rightText = [_provinceText stringByAppendingString:[@"-" stringByAppendingString:_cityText]];
            }
            
            simpleModel2 = tmp;
        }
        else{
            LocalModel *province = self.provinces[self.provinceIndex];
            self.province = province.code;
            self.city = province.code;
            SimpleCellModel *tmp = simpleModel2;
            
            if (isChinese) {
                _provinceText = province.name;
                tmp.rightText = province.name;
            }else
            {
                _provinceText = province.code;
                tmp.rightText = province.code;
            }
            
            simpleModel2 = tmp;
        }
        [self.tableView reloadData];
    }
}

//view的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (_num == 1) {
        return self.view.bounds.size.width;
    }
    //省份的label宽度为150
    if (component == 0) {
        return self.view.bounds.size.width * 0.5;
    }else{
        //市的labl的宽度为100
        return self.view.bounds.size.width * 0.5;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 34;
}

-(BOOL)needTabBar
{
    return NO;
}
@end
