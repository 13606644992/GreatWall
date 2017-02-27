//
//  KeLingQuVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "KeLingQuVC.h"
#import "ZengXianTableViewCell.h"
#import "Header.h"
@interface KeLingQuVC ()

@end

@implementation KeLingQuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 265*HEIGHT + 21;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    ZengXianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZengXianTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell creatKeLingQu];
        [cell.zengsongBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.toubaoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}
- (void)btnAction:(UIButton *)sender{
    ZengXianTableViewCell *cell = (ZengXianTableViewCell *)[[[sender superview] superview] superview];
    NSIndexPath *indexPath = [self.myList indexPathForCell:cell];
    NSLog(@"%@%@", sender.titleLabel.text, indexPath);
}
- (UITableView *)myList{
    if (!_myList) {
        _myList = [[UITableView alloc]init];
        _myList.backgroundColor = LYColor_A7;
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
