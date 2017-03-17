//
//  PayViewController.m
//  GreatWall
//
//  Created by GJ on 2017/2/27.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ChangePayViewController.h"
#import "Header.h"
#import "ChangePayTableViewCell.h"
#import "IdentityVerifyVC.h"
#import "ForgrtPasswordVC.h"

@interface ChangePayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *titleLableArray;

@end

@implementation ChangePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付密码";
    self.titleLableArray = [NSArray arrayWithObjects:@"修改支付密码",@"忘记支付密码", nil];
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth, 112*HEIGHT));
        make.left.mas_equalTo(0);
    }];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [tableView setSeparatorColor:LYColor_A6];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celling = @"celling";
    ChangePayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celling];
    if (!cell) {
        cell = [[ChangePayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celling];
    }
    cell.textLabel.text = self.titleLableArray[indexPath.row];
    cell.textLabel.textColor = LYColor_A3;
    cell.textLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56 * HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        IdentityVerifyVC *vc = [[IdentityVerifyVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        ForgrtPasswordVC *vc = [[ForgrtPasswordVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
