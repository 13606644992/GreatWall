//
//  YiWanChengVC.m
//  GreatWall
//
//  Created by GJ on 2017/1/18.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "YiWanChengVC.h"
#import "Header.h"
#import "DingDanTableViewCell.h"
#import "DingDanModel.h"
@interface YiWanChengVC ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isTop;
@end

@implementation YiWanChengVC
{
    NSMutableDictionary *heights;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    heights = [[NSMutableDictionary alloc]initWithDictionary:@{@(0):@(310)}];
    self.page = 1;
    [self.view addSubview:self.yiwanchengList];
    
    [self.yiwanchengList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 21)];
//    header.backgroundColor = LYColor_A7;
//    self.yiwanchengList.tableHeaderView = header;
//    self.yiwanchengList.separatorStyle = NO;
    [self getData];
    
//    [self.view addSubview:self.yiwanchengList];
//    self.yiwanchengList.delegate = self;
//    self.yiwanchengList.dataSource = self;
//    [self.yiwanchengList mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
//    self.yiwanchengList.showsVerticalScrollIndicator = NO;
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 21)];
//    header.backgroundColor = LYColor_A7;
//    self.yiwanchengList.tableHeaderView = header;
//    self.yiwanchengList.separatorStyle = NO;
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
    [self.yiwanchengList.mj_header endRefreshing];
    [self.yiwanchengList.mj_footer endRefreshing];
}
#pragma mark - 数据请求
- (void)getData{
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"], @"tradeSts" : @"20", @"pageSize" : @"10", @"pageIndex" : [NSString stringWithFormat:@"%ld", (long)self.page]}];
    NSLog(@"%@", paramers);
    [GJAFNetWork POST:URL_ALIANG params:paramers method:@"getTrades" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"----------已完成=========%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSDictionary *outPut = responseObject[@"output"];
            
            //            NSString *pageSize = outPut[@"pageSize"];
            //            NSString *totalCount = outPut[@"totalCount"];
            [self endRefresh];
            if (_isTop) {
                [self.dataArray removeAllObjects];
            }
            
            NSArray *tradeList = outPut[@"tradeList"];
            
            //            __block NSMutableArray *zongArray = [NSMutableArray arrayWithCapacity:0];
            
            [tradeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DingDanModel *model = [[DingDanModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                
                __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                [model.insuredList enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                    BeiBaoRenModel *renModel = [[BeiBaoRenModel alloc] init];
                    [renModel setValuesForKeysWithDictionary:obj1];
                    [array addObject:renModel];
                    
                }];
                model.insuredList = array;
                
                [self.dataArray addObject:model];
            }];
            //            NSLog(@"--%@",self.dataArray[0]);
        }
        [self.self.yiwanchengList reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 6;
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [heights[@(indexPath.row)] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    DingDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DingDanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.tag = 1002;
//        [cell creatSubView];
    }
    cell.dingDanModel = self.dataArray[indexPath.row];
    NSLog(@"-----------------------------------------------%ld,%@",indexPath.row,cell.chepaihao.text);
    [heights setObject:@([cell getHeight]) forKey:@(indexPath.row)];
    return cell;
}


- (UITableView *)yiwanchengList{
    if (!_yiwanchengList) {
        _yiwanchengList = [[UITableView alloc]init];
        _yiwanchengList.backgroundColor = LYColor_A7;
        _yiwanchengList.delegate = self;
        _yiwanchengList.dataSource = self;
        _yiwanchengList.showsVerticalScrollIndicator = NO;
        _yiwanchengList.separatorStyle = UITableViewCellSeparatorStyleNone;
        _yiwanchengList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _isTop = YES;
            self.page = 1;
            [self MJHeaderLoadTable];
            [self getData];
        }];
        _yiwanchengList.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _isTop = NO;
            self.page++;
            [self MJSetFooterTable];
            [self getData];
        }];
    }
    return _yiwanchengList;
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
