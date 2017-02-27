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
@interface QuanBuVC ()

@end

@implementation QuanBuVC
{
    NSInteger page;
    NSMutableArray *dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.quanbuList];
    self.quanbuList.delegate = self;
    self.quanbuList.dataSource = self;
    [self.quanbuList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.quanbuList.showsVerticalScrollIndicator = NO;
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 21)];
    header.backgroundColor = LYColor_A7;
    self.quanbuList.tableHeaderView = header;
    self.quanbuList.separatorStyle = NO;
    page = 0;
    [self getData];
}
- (void)getData{
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithDictionary:@{@"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:@"GJ_userId"], @"tradeSts" : @"0", @"pageSize" : @"10", @"pageIndex" : [NSString stringWithFormat:@"%ld", (long)page]}];
    NSLog(@"%@", paramers);
    [GJAFNetWork POST:URL_ALIANG params:paramers method:@"getTrades" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSLog(@"%@", responseObject[@"respMsg"]);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 219*HEIGHT + 18;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    DingDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DingDanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.tag = 1000;
        [cell creatSubView];
    }
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
