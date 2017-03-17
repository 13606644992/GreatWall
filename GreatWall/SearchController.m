
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
#import "SearchModel.h"
#import "MallCell.h"
#import "CarMallCell.h"
#import "CarNumberController.h"


@interface SearchController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString *filePath;
    NSMutableArray *searchArray;
    NSMutableArray *hotKeys;
    NSMutableArray *productArray;
}
/*
 *  高度
 */
@property (nonatomic ,strong) NSMutableDictionary *dictorys;
@property (nonatomic ,strong)UIButton *cancelBtn;
@property (nonatomic ,strong)UIButton *removeBtn;
@property (nonatomic ,strong)UILabel *removeLab;
@property (nonatomic ,strong)UIImageView *removeImg;
@property (nonatomic ,strong)UITextField *textField;
@property (nonatomic ,strong)UIView *grayView;
@property (nonatomic ,strong)NSArray *infoArray;
@property (nonatomic ,strong)UILabel *searchLabel;
@property (nonatomic ,strong)UILabel *HistoryLabel;
@property (nonatomic ,strong)NSArray *titleArray;
@property (nonatomic ,strong)UITableView *tabView;
/*
 *  表格样式
 */
@property (nonatomic ,assign) NSInteger tableViewType;

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = UIColorRGBA(242, 242, 242, 1);
    filePath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/a.txt"];
    [self setSearchHeaderWithSearch];
    [self.view addSubview:self.tabView];
    self.dictorys = [NSMutableDictionary dictionaryWithObject:@(0) forKey:@(0)];
    [DataGreatWall PostTheSetHotKeysWithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
        if (error) {
            
        }else if ([respCode isEqualToString:@"000000"]){
            hotKeys = array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabView reloadData];
            });
        }else{
            
        }
    }];
//    [self setBoundsWithSearch];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    StatusBarBlack;
    self.navigationController.navigationBarHidden = YES;
    self.tableViewType = ProductTypeModeDefailt;
    searchArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    if (!searchArray) {
        searchArray = [[NSMutableArray alloc] initWithCapacity:0];
        [searchArray writeToFile:filePath atomically:YES];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabView reloadData];
    });
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    StatusBarBlack;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    StatusBarWhite;
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
        make.right.equalTo(naView).with.offset(-18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(35*WEIGHT, 16*HEIGHT));
    }];
    [self.view addSubview:view];
    [view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelBtn);
        make.right.mas_equalTo(self.cancelBtn.mas_left).with.offset(-11*WEIGHT);
        make.height.equalTo(@(32*HEIGHT));
        make.width.equalTo(@(291.5*WEIGHT));
    }]; 
}
-(UIView *)setBoundsWithHotSearch
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 145*HEIGHT)];
    HeaderView.backgroundColor = [UIColor whiteColor];

    UIView *lightView = [[UIView alloc] init];
    lightView.backgroundColor = LYColor_A7;
    [HeaderView addSubview:lightView];
    [lightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(HeaderView);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth, 38*HEIGHT));
    }];
    
    [HeaderView addSubview:self.searchLabel];
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(HeaderView).with.offset(18*WEIGHT);
        make.centerY.equalTo(lightView);
        make.size.mas_equalTo(CGSizeMake(100*WEIGHT, 12*HEIGHT));
    }];
    /*********************************/
    __block UIButton *lastBtn = nil;
    int intes = 18*HEIGHT;
    int num = 4;
    for (int i = 0; i < 8; i++) {

        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:13*HEIGHT];
        if (i<hotKeys.count) {
            SearchModel *model = hotKeys[i];
            [searchBtn setTitle:model.keyName forState:UIControlStateNormal];
        }
        [searchBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
        searchBtn.layer.cornerRadius = 2.0f;
        [searchBtn setBackgroundColor:LYColor_A7];
        searchBtn.clipsToBounds = YES;
        [searchBtn addTarget:self action:@selector(hotClick:) forControlEvents:UIControlEventTouchUpInside];
        searchBtn.tag = i+1;
        [HeaderView addSubview:searchBtn];
        // 添加约束
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(29*HEIGHT);
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
                make.top.mas_equalTo(searchBtn.superview).offset(56);
            } else {
                make.top.mas_equalTo(56 + ( i / num )* (25*HEIGHT + intes));
            }
        }];
        lastBtn = searchBtn;
    }
    
    return HeaderView;

}
-(UIView *)setBoundsWithHistoryView
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 38*HEIGHT)];
    HeaderView.backgroundColor = [UIColor whiteColor];
    UIView *lightView = [[UIView alloc] init];
    lightView.backgroundColor = LYColor_A7;
    [HeaderView addSubview:lightView];
    [lightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(HeaderView);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth, 38*HEIGHT));
    }];
    [HeaderView addSubview:self.HistoryLabel];
    [self.HistoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(HeaderView).with.offset(20*HEIGHT);
        make.top.equalTo(HeaderView).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 30*HEIGHT));
    }];
    [HeaderView addSubview:self.removeLab];
    [self.removeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(HeaderView.mas_right).with.offset(-18*HEIGHT);
        make.centerY.equalTo(self.HistoryLabel);
        make.size.mas_equalTo(CGSizeMake(25*WEIGHT, 12*HEIGHT));
    }];
    [HeaderView addSubview:self.removeImg];
    [self.removeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.removeLab.mas_left).with.offset(-6*HEIGHT);
        make.centerY.equalTo(self.HistoryLabel);
        make.size.mas_equalTo(CGSizeMake(15*WEIGHT, 15*HEIGHT));
    }];
    [HeaderView addSubview:self.removeBtn];
    [self.removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.removeImg);
        make.right.equalTo(self.removeLab);
        make.top.bottom.equalTo(HeaderView);
    }];
    return HeaderView;
}
//热门搜索
-(void)hotClick:(UIButton *)sender
{
    NSLog(@"----------%ld",(long)sender.tag);
}
#pragma mark ------------TableViewDelegate---------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.tableViewType == ProductTypeModeDefailt) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableViewType == ProductTypeModeDefailt) {
        return 59*HEIGHT;
    }
    if (productArray.count>indexPath.row) {
        MallProduct *model = productArray[indexPath.row];
        if ([[NSString stringWithFormat:@"%@",model.classType] isEqualToString:@"1"]) {
            return 132*HEIGHT;
        }else{
            return 147*HEIGHT;
        }
    }
    return 147*HEIGHT;
}
-(CGFloat)tableView:(UITableView *)t ableViewheightForFooterInSection:(NSInteger)section
{
    if (self.tableViewType == ProductTypeModeDefailt) {
        return 0.01;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.tableViewType == ProductTypeModeDefailt) {
        if (section == 0) {
            return 145*HEIGHT;
        }
        return 36*HEIGHT;
    }
    return 13*HEIGHT;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tableViewType == ProductTypeModeDefailt) {
        if (section == 0) {
            return [self setBoundsWithHotSearch];
        }
        return [self setBoundsWithHistoryView];
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableViewType == ProductTypeModeDefailt) {
        if (section == 1) {
            return searchArray.count;
        }
        return 0;
    }
    return productArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewType == ProductTypeModeDefailt) {
        SearchCell *cell = [SearchCell cellWithTableView:tableView];
        [cell.removeBtn addTarget:self action:@selector(onlyRemoveClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.removeBtn.tag = indexPath.row+100;
        cell.titleLab.text = searchArray[indexPath.row];
        return cell;
    }else{
        MallProduct *model = productArray[indexPath.row];
        if ([[NSString stringWithFormat:@"%@",model.classType] isEqualToString:@"1"]) {
            CarMallCell *cell = [CarMallCell MallcellWithTableView:tableView];
            cell.model = model;
            return cell;
        }else{
            MallCell *cell = [MallCell MallcellWithTableView:tableView];
            cell.model = model;
            return cell;
        }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewType == ProductTypeModeDefailt) {
        [DataGreatWall PostTheProductTypeWith:@"" WithThePageIndex:@"1" WithThePageSize:@"10" WithTheKey:searchArray[indexPath.row] WithTheTargetID:@"" isGetDefault:@"0" WithDefaultNum:@"" WithSortCode:@"0" WithBenefitNum:@"3" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
            
            if (error) {
                
            }else if ([respCode isEqualToString:@"000000"]){
                if (array.count>0) {
                    productArray = array;
                    self.tableViewType = ProductTypeModeProducts;
                    if (searchArray.count>=20) {
                        [searchArray removeObjectAtIndex:searchArray.count-1];
                    }
                    [searchArray insertObject:self.textField.text atIndex:0];
                    [self deleteTheSameArray];
                    [searchArray writeToFile:filePath atomically:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tabView reloadData];
                    });
                }else{

                }
            }else{
                
            }
            
        }];
    }else{
        MallProduct *model = productArray[indexPath.row];
        if ([[NSString stringWithFormat:@"%@",model.classType] isEqualToString:@"1"]) {
            self.hidesBottomBarWhenPushed=YES;
            CarNumberController *baseVC = [[CarNumberController alloc] init];
         
            [self.navigationController pushViewController:baseVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            
        }else{
            self.hidesBottomBarWhenPushed=YES;
            DescriptionController *baseVC = [[DescriptionController alloc] init];
         
            [self.navigationController pushViewController:baseVC animated:YES];
//            self.hidesBottomBarWhenPushed = NO;
        }
   
    }
}

-(void)onlyRemoveClick:(UIButton *)sender
{
    [searchArray removeObjectAtIndex:sender.tag-100];
    [searchArray writeToFile:filePath atomically:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabView reloadData];
    });
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
    if ([textField.text isEqualToString:@""]) {
        return NO;
    }
    [DataGreatWall PostTheProductTypeWith:@"" WithThePageIndex:@"1" WithThePageSize:@"10" WithTheKey:self.textField.text WithTheTargetID:@"" isGetDefault:@"0" WithDefaultNum:@"" WithSortCode:@"0" WithBenefitNum:@"3" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
        
        if (error) {
//            self.tableViewType = ProductTypeModeDefailt;

        }else if ([respCode isEqualToString:@"000000"]){
            if (array.count>0) {
                productArray = array;
                self.tableViewType = ProductTypeModeProducts;
                if (searchArray.count>=20) {
                    [searchArray removeObjectAtIndex:searchArray.count-1];
                }
                [searchArray insertObject:self.textField.text atIndex:0];
                [self deleteTheSameArray];
                [searchArray writeToFile:filePath atomically:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tabView reloadData];
                });
            }else{
//                self.tableViewType = ProductTypeModeDefailt;
            }
        }else{
//            self.tableViewType = ProductTypeModeDefailt;

        }
        
    }];
    
    
    

    return YES;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark ------------controller----------
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWindowWidth, ScreenWindowHeight-64) style:UITableViewStylePlain];
        _tabView.backgroundColor = LYColor_A7;
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.separatorColor = [UIColor clearColor];
    }
    return _tabView;
}
-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"汇保险";
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.layer.cornerRadius = 16.0f;
        _textField.clipsToBounds = YES;
        _textField.backgroundColor = LYColor_A6;
        _textField.font = [UIFont systemFontOfSize:14*WEIGHT];
        UIImageView *searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo(siusuoyemian)"]];
        searchImg.frame = CGRectMake(13*WEIGHT, 3.5*HEIGHT, 12.5*WEIGHT, 12.5*HEIGHT);
        UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32.5*WEIGHT, 20*HEIGHT)];
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
        [_cancelBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16*WEIGHT];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
     }
    return _cancelBtn;
}
-(UILabel *)searchLabel
{
    if (!_searchLabel) {
        _searchLabel = [[UILabel alloc] init];
        _searchLabel.textColor = LYColor_A4;
        _searchLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        _searchLabel.text = @"热门搜索";
    }
    return _searchLabel;
}
-(UILabel *)HistoryLabel
{
    if (!_HistoryLabel) {
        _HistoryLabel = [[UILabel alloc] init];
        _HistoryLabel.text=@"历史搜索";
        _HistoryLabel.textColor = LYColor_A4;
        _HistoryLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _HistoryLabel;
}
-(UILabel *)removeLab
{
    if (!_removeLab) {
        _removeLab = [[UILabel alloc] init];
        _removeLab.font = [UIFont systemFontOfSize:12*WEIGHT];
        _removeLab.text = @"清空";
        _removeLab.textColor =LYColor_A4;
    }
    return _removeLab;
}
-(UIImageView *)removeImg
{
    if (!_removeImg) {
        _removeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qingkong(sousuoyeman)"]];
    }
    return _removeImg;
}
-(UIButton *)removeBtn
{
    if (!_removeBtn) {
        _removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_removeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        _removeBtn.backgroundColor = [UIColor redColor];
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
