//
//  CustomServiceVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CustomServiceVC.h"
#import "Header.h"
#import "CustomServiceCell.h"
#import "CustomServiceDetailVC.h"
@interface CustomServiceVC ()

@end
@implementation CustomServiceVC
{
    UITableView *questionList;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    StatusBarBlack;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"客服中心";
    UIImageView *headIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kefu-kefu.png"]];
    headIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:headIMG];
    [headIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(117*HEIGHT);
    }];
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headIMG.mas_bottom).with.offset(18);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(75*HEIGHT);
    }];
    UIButton *tixianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tixianBtn setTitle:@"结算提现" forState:UIControlStateNormal];
    [tixianBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
    tixianBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
    [background addSubview:tixianBtn];
    [tixianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 20*HEIGHT));
    }];
    [tixianBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *line_firstIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kehu-line.png"]];
    line_firstIMG.contentMode = UIViewContentModeScaleAspectFit;
    [background addSubview:line_firstIMG];
    [line_firstIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(tixianBtn.mas_left).with.offset(-10*WIDTH);
        make.centerY.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(13*WIDTH, 23*HEIGHT));
    }];
    UIButton *zhidaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhidaoBtn setTitle:@"新手指导" forState:UIControlStateNormal];
    [zhidaoBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
    zhidaoBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
    [background addSubview:zhidaoBtn];
    [zhidaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.right.mas_equalTo(line_firstIMG.mas_left).with.offset(-10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 20*HEIGHT));
    }];
    [zhidaoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *line_secondIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kehu-line.png"]];
    line_secondIMG.contentMode = UIViewContentModeScaleAspectFit;
    [background addSubview:line_secondIMG];
    [line_secondIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tixianBtn.mas_right).with.offset(10*WIDTH);
        make.centerY.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(13*WIDTH, 23*HEIGHT));
    }];
    UIButton *dianhuaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dianhuaBtn setTitle:@"客服电话" forState:UIControlStateNormal];
    [dianhuaBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
    dianhuaBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
    [background addSubview:dianhuaBtn];
    [dianhuaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.left.mas_equalTo(line_secondIMG.mas_right).with.offset(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 20*HEIGHT));
    }];
    [dianhuaBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    zhidaoBtn.tag = 1000;
    tixianBtn.tag = 1001;
    dianhuaBtn.tag = 1002;
    //猜你要问
    UILabel *sectionLabel = [[UILabel alloc]init];
    sectionLabel.text = @"猜你要问";
    sectionLabel.textColor = LYColor_A4;
    sectionLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:sectionLabel];
    [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(background.mas_bottom).with.offset(18);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13));
    }];
    //问题列表
    questionList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    questionList.delegate = self;
    questionList.dataSource = self;
    [self.view addSubview:questionList];
    [questionList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sectionLabel.mas_bottom).with.offset(12);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(245*HEIGHT);
    }];
    questionList.bounces = NO;
    //重新设置分割线
    if ([questionList respondsToSelector:@selector(setSeparatorInset:)]) {
        [questionList setSeparatorInset:UIEdgeInsetsMake(0, 18*WIDTH, 0, 0)];
    }
    [questionList setSeparatorColor:LYColor_A6];
   //查看更多问题
    UIButton *moreQuestionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreQuestionBtn setTitle:@"查看更多问题" forState:UIControlStateNormal];
    [moreQuestionBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
    moreQuestionBtn.titleLabel.font = [UIFont systemFontOfSize:16*HEIGHT];
    moreQuestionBtn.backgroundColor = [UIColor whiteColor];
    moreQuestionBtn.tag = 1003;
    [moreQuestionBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreQuestionBtn];
    [moreQuestionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(questionList.mas_bottom).with.offset(18*HEIGHT);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(339*WIDTH, 44*HEIGHT));
    }];
    [moreQuestionBtn layoutIfNeeded];
    moreQuestionBtn.layer.cornerRadius = 4.0f;
    moreQuestionBtn.layer.borderWidth = 1.0;
    moreQuestionBtn.layer.borderColor = LYColor_A4.CGColor;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    CustomServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CustomServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            cell.question.text = @"如何快速上手？";
            break;
        case 1:
            cell.question.text = @"已经投保成功的保单如何进行查询？";
            break;
        case 2:
            cell.question.text = @"如何办理理赔？";
            break;
        case 3:
            cell.question.text = @"电子保单有效力吗？";
            break;
        case 4:
            cell.question.text = @"怎么领取赠险？";
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWindowWidth);
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger row = indexPath.row;
    CustomServiceCell *cell = [questionList cellForRowAtIndexPath:indexPath];
    NSLog(@"%@", cell.question.text);
//    switch (row) {
//        case 0:
//            NSLog(@"如何快速上手？");
//            break;
//        case 1:
//            NSLog(@"已经投保成功的保单如何进行查询？");
//            break;
//        case 2:
//            NSLog(@"如何办理理赔？");
//            break;
//        case 3:
//            NSLog(@"电子保单有效力吗？");
//            break;
//        case 4:
//            NSLog(@"怎么领取赠险？");
//            break;
//        default:
//            break;
//    }
    CustomServiceDetailVC *customServiceDetail = [[CustomServiceDetailVC alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:customServiceDetail animated:YES];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49*HEIGHT;
}
- (void)btnAction:(UIButton *)sender{
    NSLog(@"%ld", (long)sender.tag);
    if (sender.tag == 1002) {
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18686570371"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
