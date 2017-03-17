//
//  QuanBuVC.m
//  GreatWall
//
//  Created by GJ on 2017/1/18.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "QuanBuVC.h"
#import "DingDanTableViewCell.h"
#import "Header.h"
#import "DingDanModel.h"
@interface QuanBuVC ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isTop;
@end

@implementation QuanBuVC
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
    [self.view addSubview:self.quanbuList];
    
    [self.quanbuList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 21)];
//    header.backgroundColor = LYColor_A7;
//    self.quanbuList.tableHeaderView = header;
//    self.quanbuList.separatorStyle = NO;
    [self getData];
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
    [self.quanbuList.mj_header endRefreshing];
    [self.quanbuList.mj_footer endRefreshing];
}
#pragma mark - 数据请求
- (void)getData{
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"], @"tradeSts" : @"0", @"pageSize" : @"10", @"pageIndex" : [NSString stringWithFormat:@"%ld", (long)self.page]}];
    NSLog(@"%@", paramers);
    [GJAFNetWork POST:URL_ALIANG params:paramers method:@"getTrades" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"---------全部订单responseObject========%@", responseObject);
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
        [self.quanbuList reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
//    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"--height--%ld---%f", indexPath.row,[heights[@(indexPath.row)] floatValue]);
    return [heights[@(indexPath.row)] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    DingDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DingDanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.tag = 1000;
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
    NSIndexPath *cellPath = [self.quanbuList  indexPathForCell:myCell];
    NSLog(@"第%ld行", (long)cellPath.row);
}
- (UITableView *)quanbuList{
    if (!_quanbuList) {
        _quanbuList = [[UITableView alloc]init];
        _quanbuList.backgroundColor = LYColor_A7;
        _quanbuList.delegate = self;
        _quanbuList.dataSource = self;
        _quanbuList.showsVerticalScrollIndicator = NO;
        _quanbuList.separatorStyle = UITableViewCellSeparatorStyleNone;
        _quanbuList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _isTop = YES;
            self.page = 1;
            [self MJHeaderLoadTable];
            [self getData];
        }];
        _quanbuList.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _isTop = NO;
            self.page++;
            [self MJSetFooterTable];
            [self getData];
        }];
    }
    return _quanbuList;
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
