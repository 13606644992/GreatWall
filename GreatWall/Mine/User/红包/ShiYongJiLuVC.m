//
//  ShiYongJiLuVC.m
//  GreatWall
//
//  Created by GJ on 2017/1/17.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ShiYongJiLuVC.h"
#import "Header.h"
#import "HongBaoTableViewCell.h"
#import "HongBaoModel.h"
@interface ShiYongJiLuVC ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isTop;
@end

@implementation ShiYongJiLuVC

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    self.page = 1;
    [self getData];
    [self.view addSubview:self.shiyongjiluList];
    self.shiyongjiluList.delegate = self;
    self.shiyongjiluList.dataSource = self;
    [self.shiyongjiluList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.shiyongjiluList.showsVerticalScrollIndicator = NO;
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 21)];
    header.backgroundColor = LYColor_A7;
    self.shiyongjiluList.tableHeaderView = header;
    self.shiyongjiluList.separatorStyle = NO;
}
#pragma mark -----MJRefresh----------
-(void)MJHeaderLoadTable
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2.0f];
}
-(void)MJSetFooterTable
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2.0f];
}
-(void)endRefresh{
    [self.shiyongjiluList.mj_header endRefreshing];
    [self.shiyongjiluList.mj_footer endRefreshing];
}

#pragma mark - 数据请求
- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"],@"sts":@"2",@"couponType":@"2",@"pageIndex":[NSString stringWithFormat:@"%ld",(long)self.page],@"pageSize":@"10"}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"getUserCouponsList" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            NSLog(@"红包使用记录responseObject=====%@",responseObject);
            [self endRefresh];
            if (_isTop) {
                [self.dataSource removeAllObjects];
            }
            
            NSArray *oucouponListtput = responseObject[@"output"][@"couponList"];
            for (NSDictionary *dictionary in oucouponListtput) {
                HongBaoModel *model = [[HongBaoModel alloc]init];
                [model setValuesForKeysWithDictionary:dictionary];
                [self.dataSource addObject:model];
            }
            
        }
        [self.shiyongjiluList reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118*HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HongBaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HongBaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.tag = 1001;
        [cell creatSubView];
    }
    cell.hongBaoModel = self.dataSource[indexPath.row];
    return cell;
}

- (UITableView *)shiyongjiluList{
    if (!_shiyongjiluList) {
        _shiyongjiluList = [[UITableView alloc]init];
        _shiyongjiluList.backgroundColor = LYColor_A7;
        _shiyongjiluList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _isTop = YES;
            self.page = 1;
            [self MJHeaderLoadTable];
            [self getData];
        }];
        _shiyongjiluList.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _isTop = NO;
            self.page++;
            [self MJSetFooterTable];
            [self getData];
        }];
    }
    return _shiyongjiluList;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
