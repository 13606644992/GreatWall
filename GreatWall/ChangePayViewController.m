//
//  PayViewController.m
//  GreatWall
//
//  Created by GJ on 2017/2/27.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ChangePayViewController.h"
#import "Header.h"

@interface ChangePayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *titleLableArray;

@end

@implementation ChangePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLableArray = [NSArray arrayWithObjects:@"修改支付密码",@"忘记支付密码", nil];
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celling = @"celling";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celling];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celling];
    }
    cell.textLabel.text = self.titleLableArray[indexPath.row];
    cell.textLabel.textColor = LYColor_A3;
    cell.textLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56 * HEIGHT;
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
