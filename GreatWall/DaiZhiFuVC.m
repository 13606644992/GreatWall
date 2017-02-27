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
@interface DaiZhiFuVC ()

@end

@implementation DaiZhiFuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.daizhifuList];
    self.daizhifuList.delegate = self;
    self.daizhifuList.dataSource = self;
    [self.daizhifuList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.daizhifuList.showsVerticalScrollIndicator = NO;
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 21)];
    header.backgroundColor = LYColor_A7;
    self.daizhifuList.tableHeaderView = header;
    self.daizhifuList.separatorStyle = NO;
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
        cell.tag = 1001;
        [cell creatSubView];
        [cell.zhifuBtn addTarget:self action:@selector(zhifuAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
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
