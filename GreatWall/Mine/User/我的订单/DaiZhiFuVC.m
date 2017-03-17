//
//  DaiZhiFuVC.m
//  GreatWall
//
//  Created by GJ on 2017/1/18.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DaiZhiFuVC.h"
#import "Header.h"
#import "DingDanTableViewCell.h"
#import "DingDanModel.h"
@interface DaiZhiFuVC ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isTop;
@end

@implementation DaiZhiFuVC
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
    self.page = 1;
    heights = [[NSMutableDictionary alloc]initWithDictionary:@{@(0):@(310)}];
    [self.view addSubview:self.daizhifuList];
    
    [self.daizhifuList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 21)];
//    header.backgroundColor = LYColor_A7;
//    self.daizhifuList.tableHeaderView = header;
//    self.daizhifuList.separatorStyle = NO;
//    [self getData];
    
    
//    [self.view addSubview:self.daizhifuList];
//    self.daizhifuList.delegate = self;
//    self.daizhifuList.dataSource = self;
//    [self.daizhifuList mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
//    self.daizhifuList.showsVerticalScrollIndicator = NO;
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 21)];
//    header.backgroundColor = LYColor_A7;
//    self.daizhifuList.tableHeaderView = header;
//    self.daizhifuList.separatorStyle = NO;
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
    [self.daizhifuList.mj_header endRefreshing];
    [self.daizhifuList.mj_footer endRefreshing];
}
#pragma mark - 数据请求
- (void)getData{
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"], @"tradeSts" : @"10", @"pageSize" : @"10", @"pageIndex" : [NSString stringWithFormat:@"%ld", (long)self.page]}];
    NSLog(@"%@", paramers);
    [GJAFNetWork POST:URL_ALIANG params:paramers method:@"getTrades" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"--------待支付=======%@", responseObject);
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
        [self.self.daizhifuList reloadData];
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
        cell.tag = 1001;
//        [cell creatSubView];
        
    }
    cell.dingDanModel = self.dataArray[indexPath.row];
    [heights setObject:@([cell getHeight]) forKey:@(indexPath.row)];
    [cell.zhifuBtn addTarget:self action:@selector(zhifuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

/**
 支付按钮方法
 */
- (void)zhifuAction:(UIButton *)sender{
    DingDanTableViewCell* myCell = (DingDanTableViewCell *)[[[sender superview]superview]superview];
    NSIndexPath *cellPath = [self.daizhifuList  indexPathForCell:myCell];
    NSLog(@"第%ld行", (long)cellPath.row);
}

- (UITableView *)daizhifuList{
    if (!_daizhifuList) {
        _daizhifuList = [[UITableView alloc]init];
        _daizhifuList.backgroundColor = LYColor_A7;
        _daizhifuList.delegate = self;
        _daizhifuList.dataSource = self;
        _daizhifuList.separatorStyle = UITableViewCellSeparatorStyleNone;
        _daizhifuList.showsVerticalScrollIndicator = NO;
        _daizhifuList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _isTop = YES;
            self.page = 1;
            [self MJHeaderLoadTable];
            [self getData];
        }];
        _daizhifuList.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _isTop = NO;
            self.page++;
            [self MJSetFooterTable];
            [self getData];
        }];
    }
    return _daizhifuList;
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
