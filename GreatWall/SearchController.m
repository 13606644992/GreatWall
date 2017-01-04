
//
//  SearchController.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "SearchController.h"
#import "Header.h"
#import "SearchCell.h"

@interface SearchController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString *filePath;
    NSMutableArray *searchArray;
}
@property (nonatomic ,strong)UIButton *cancelBtn;
@property (nonatomic ,strong)UIButton *removeBtn;
@property (nonatomic ,strong)UITextField *textField;
@property (nonatomic ,strong)UIView *grayView;
@property (nonatomic ,strong)NSArray *infoArray;
@property (nonatomic ,strong)UILabel *searchLabel;
@property (nonatomic ,strong)UILabel *HistoryLabel;
@property (nonatomic ,strong)NSArray *titleArray;
@property (nonatomic ,strong)UITableView *tabView;


@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = UIColorRGBA(242, 242, 242, 1);
    filePath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/a.txt"];
    [self setSearchHeaderWithSearch];
    [self setBoundsWithSearch];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    searchArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    if (!searchArray) {
        searchArray = [[NSMutableArray alloc] initWithCapacity:0];
        [searchArray writeToFile:filePath atomically:YES];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabView reloadData];
    });
}
//导航
-(void)setSearchHeaderWithSearch
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 64)];
    view.backgroundColor =UIColorRGBA(255, 255, 255, 1);
    [view addSubview:self.cancelBtn];
    __weak UIView *naView = view;
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(naView).with.offset(30);
        make.right.equalTo(naView).with.offset(-15*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(40, 25));
    }];
    [self.view addSubview:view];
    [view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(naView).with.offset(20*HEIGHT);
        make.top.equalTo(naView).with.offset(30);
        make.right.mas_equalTo(self.cancelBtn.mas_left).with.offset(-10);
        make.height.equalTo(@(25));
    }]; 
}
-(void)setBoundsWithSearch
{
    [self.view addSubview:self.searchLabel];
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20*HEIGHT);
        make.top.equalTo(self.view).with.offset(70);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    /*********************************/
    __block UIButton *lastBtn = nil;
    int intes = 20*HEIGHT;
    int num = 4;
    for (int i = 0; i < 8; i++) {

        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:13*HEIGHT];
        [searchBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        searchBtn.layer.borderWidth = 1.0f;
        searchBtn.layer.borderColor = [UIColor grayColor].CGColor;
        searchBtn.layer.cornerRadius = 5;
        [searchBtn setBackgroundColor:[UIColor whiteColor]];
        searchBtn.clipsToBounds = YES;
        [searchBtn addTarget:self action:@selector(hotClick:) forControlEvents:UIControlEventTouchUpInside];
        searchBtn.tag = i+1;
        [self.view addSubview:searchBtn];
        // 添加约束
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25*HEIGHT);
            if (lastBtn) {
                make.width.equalTo(lastBtn);
            } else {
                if (i % num != 0) {
                    make.width.mas_equalTo((searchBtn.superview.frame.size.width - (num + 1)* intes)/4);
                }
            }
            if (i % num == 0) {
                make.left.mas_equalTo(searchBtn.superview).offset(intes);
            } else {
                make.left.mas_equalTo(lastBtn.mas_right).offset(intes);
            }
            if (i % num == (num - 1)) {
                make.right.mas_equalTo(searchBtn.superview).offset(-intes);
            }
            if (i / num == 0) {
                make.top.mas_equalTo(searchBtn.superview).offset(110);
            } else {
                make.top.mas_equalTo(110 + ( i / num )* (25*HEIGHT + intes));
            }
        }];
        lastBtn = searchBtn;
    }
    [self.view addSubview:self.tabView];

}
-(void)hotClick:(UIButton *)sender
{
    NSLog(@"----------%ld",sender.tag);
}
#pragma mark ------------TableViewDelegate---------
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*HEIGHT;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 40*HEIGHT)];
    HeaderView.backgroundColor = [UIColor whiteColor];
    [HeaderView addSubview:self.HistoryLabel];
    [self.HistoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(HeaderView).with.offset(20*HEIGHT);
        make.top.equalTo(HeaderView).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 30*HEIGHT));
    }];
    [HeaderView addSubview:self.removeBtn];
    [self.removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(HeaderView.mas_right).with.offset(-20*HEIGHT);
        make.top.equalTo(@(10));
        make.size.mas_equalTo(CGSizeMake(20*HEIGHT, 20*HEIGHT));
    }];
    return HeaderView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searchArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCell *cell = [SearchCell cellWithTableView:tableView];
    
    return cell;
}
-(void)deleteTheSameArray
{
    NSMutableArray *Array = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [searchArray count]; i++)
    {
        if ([Array containsObject:[searchArray objectAtIndex:i]] == NO)
        {
            [Array addObject:[searchArray objectAtIndex:i]];
        }
    }
    searchArray = Array;
}
//删除历史
-(void)removeClick
{
    [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定清空历史搜索么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [searchArray removeAllObjects];
        NSFileManager *fileManeger = [NSFileManager defaultManager];
        [fileManeger removeItemAtPath:filePath error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabView reloadData];
        });
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (searchArray.count>=20) {
        [searchArray removeObjectAtIndex:searchArray.count-1];
    }
    [searchArray insertObject:self.textField.text atIndex:0];
    [self deleteTheSameArray];
    [searchArray writeToFile:filePath atomically:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabView reloadData];
    });
    return YES;
}
#pragma mark ------------controller----------
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100+100*HEIGHT, ScreenWindowWidth, ScreenWindowHeight-100-100*HEIGHT) style:UITableViewStylePlain];
        _tabView.delegate = self;
//        _tabView.backgroundColor = [UIColor greenColor];
        _tabView.dataSource = self;
        _tabView.rowHeight = 40*HEIGHT;
//        _tabView.backgroundColor = [UIColor whiteColor];
    }
    return _tabView;
}
-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"汇保险";
        _textField.borderStyle = UITextBorderStyleLine;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.font = [UIFont systemFontOfSize:14];
        UIImageView *searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo(siusuoyemian)"]];
        searchImg.frame = CGRectMake(10, 3.5, 12.5, 12.5);
        UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30*WEIGHT, 20*HEIGHT)];
        [searchView addSubview:searchImg];
        _textField.leftView = searchView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
    }
    return _textField;
}
-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        _cancelBtn.backgroundColor = [UIColor yellowColor];
     }
    return _cancelBtn;
}
-(UILabel *)searchLabel
{
    if (!_searchLabel) {
        _searchLabel = [[UILabel alloc] init];
        _searchLabel.textColor = [UIColor grayColor];
        _searchLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        _searchLabel.text = @"大家都在搜";
    }
    return _searchLabel;
}
-(UILabel *)HistoryLabel
{
    if (!_HistoryLabel) {
        _HistoryLabel = [[UILabel alloc] init];
        _HistoryLabel.text=@"搜索记录";
        _HistoryLabel.textColor = [UIColor grayColor];
        _HistoryLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _HistoryLabel;
}
-(UIButton *)removeBtn
{
    if (!_removeBtn) {
        _removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _removeBtn.backgroundColor = [UIColor redColor];
        [_removeBtn addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBtn;
}
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"汇保险",@"平安车险",@"意外险",@"防癌",@"寿险",@"分红",@"境外游",@"老人"];
    }
    return _titleArray;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancelBtnClick
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
