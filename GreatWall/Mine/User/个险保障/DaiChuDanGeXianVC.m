//
//  DaiChuDanGeXianVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DaiChuDanGeXianVC.h"
#import "Header.h"
#import "GeXianTableViewCell.h"
#import "GeXianDetailVC.h"
#import "BaoDanModel.h"
@interface DaiChuDanGeXianVC ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isTop;

@end

@implementation DaiChuDanGeXianVC
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
    [self.view addSubview:self.myList];
    self.myList.delegate = self;
    self.myList.dataSource = self;
    self.myList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.myList.showsVerticalScrollIndicator = NO;
    self.page = 1;
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
    [self.myList.mj_header endRefreshing];
    [self.myList.mj_footer endRefreshing];
}
#pragma mark - 数据请求
- (void)getData{
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"], @"policySts" : @"10",@"classType":@"2", @"pageSize" : @"10", @"pageIndex" : [NSString stringWithFormat:@"%ld", (long)self.page]}];
    NSLog(@"%@", paramers);
    [GJAFNetWork POST:URL_ALIANG params:paramers method:@"getPolicies" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"个保--待出单--responseObject==%@", responseObject);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            NSDictionary *outPut = responseObject[@"output"];
            
            //            NSString *pageSize = outPut[@"pageSize"];
            //            NSString *totalCount = outPut[@"totalCount"];
            [self endRefresh];
            if (_isTop) {
                [self.dataArray removeAllObjects];
            }
            
            NSArray *tradeList = outPut[@"policyList"];
            
            //            __block NSMutableArray *zongArray = [NSMutableArray arrayWithCapacity:0];
            
            [tradeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BaoDanModel *model = [[BaoDanModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                
                __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                [model.insuredList enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                    BeiBaoXianRenModel *renModel = [[BeiBaoXianRenModel alloc] init];
                    [renModel setValuesForKeysWithDictionary:obj1];
                    [array addObject:renModel];
                    
                }];
                model.insuredList = array;
                
                [self.dataArray addObject:model];
            }];
            //            NSLog(@"--%@",self.dataArray[0]);
        }
        [self.myList reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [heights[@(indexPath.row)] floatValue];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    GeXianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GeXianTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.tag = 1000;
        [cell creatSubView];
    }
    cell.baoDanModel = self.dataArray[indexPath.row];
    [heights setObject:@([cell getHeight]) forKey:@(indexPath.row)];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GeXianDetailVC *gexianDetail = [[GeXianDetailVC alloc]init];
    BaoDanModel *model = self.dataArray[indexPath.row];
    gexianDetail.detailID = model.detailId;
    [self.navigationController pushViewController:gexianDetail animated:YES];
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
