//
//  YiGuoQiZengXianVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "YiGuoQiZengXianVC.h"
#import "Header.h"
#import "ZengXianTableViewCell.h"
#import "ZengXianModel.h"

@interface YiGuoQiZengXianVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myList;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isTop;

@end

@implementation YiGuoQiZengXianVC

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self getData];
    self.myList.delegate = self;
    self.myList.dataSource = self;
    [self.view addSubview:self.myList];
    [self.myList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.myList.showsVerticalScrollIndicator = NO;
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 21)];
    header.backgroundColor = LYColor_A7;
    self.myList.tableHeaderView = header;
    self.myList.separatorStyle = NO;
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
    [self.myList.mj_header endRefreshing];
    [self.myList.mj_footer endRefreshing];
}

#pragma mark - 数据请求
- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"],@"sts":@"-1",@"pageIndex":[NSString stringWithFormat:@"%ld",(long)self.page],@"pageSize":@"10"}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"presentProduct" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"赠险已使用responseObject=====%@",responseObject);
        if ([responseObject[@"respCode"]isEqualToString:@"000000"]) {
            [self endRefresh];
            if (_isTop) {
                [self.dataSource removeAllObjects];
            }
            NSArray *output = responseObject[@"output"][@"presentProductsRsp"];
            for (NSDictionary *dictionary in output) {
                ZengXianModel *model = [[ZengXianModel alloc]init];
                [model setValuesForKeysWithDictionary:dictionary];
                [self.dataSource addObject:model];
            }
        }
        [self.myList reloadData];
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
    return 211*HEIGHT + 21;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    ZengXianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZengXianTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell creatYiShiYong];
    }
    cell.zengXianModel = self.dataSource[indexPath.row];
    return cell;
}

- (UITableView *)myList{
    if (!_myList) {
        _myList = [[UITableView alloc]init];
        _myList.backgroundColor = LYColor_A7;
        _myList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _isTop = YES;
            self.page = 1;
            [self MJHeaderLoadTable];
            [self getData];
        }];
        _myList.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _isTop = NO;
            self.page++;
            [self MJSetFooterTable];
            [self getData];
        }];
    }
    return _myList;
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
