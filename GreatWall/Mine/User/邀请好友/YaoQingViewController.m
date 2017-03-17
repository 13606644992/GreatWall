//
//  YaoQingViewController.m
//  GreatWall
//
//  Created by GJ on 2017/3/8.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "YaoQingViewController.h"
#import "Header.h"
#import "FriendCell.h"
#import "YaoQingModel.h"

@interface YaoQingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation YaoQingViewController
{
    UITableView *friendsList;
    UILabel *successCount;
    UILabel *totalIncome;
    UIImageView *headIMG_1;
    UIImageView *headIMG_2;
    UIImageView *headIMG_3;
    UILabel *name_1;
    UILabel *name_2;
    UILabel *name_3;
    UILabel *income_1;
    UILabel *income_2;
    UILabel *income_3;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    self.navigationController.navigationBar.translucent = NO;
    StatusBarBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {

    [self getData];
    self.navigationItem.title = @"推荐奖励";
    [self addFriendsList];
}
#pragma mark - 数据解析
- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"]}];
    [GJAFNetWork POST:URL_ALIANG params:dic method:@"inviteFriend" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"邀请好友responseObject=============%@",responseObject);
        if ([responseObject[@"respCode" ]isEqualToString:@"000000"]) {
            NSArray *userAccountDetailRecord = responseObject[@"output"][@"userAccountDetailRecord"];
            for (NSDictionary *dictionary in userAccountDetailRecord) {
                //累计收入
                NSString *acctSum = responseObject[@"output"][@"acctSum"];
                successCount.text = [NSString stringWithFormat:@"%@位",acctSum];
                //成功邀请位数
                NSString *count = responseObject[@"output"][@"count"];
                totalIncome.text = [NSString stringWithFormat:@"%.2f元",[count floatValue]/100 ];
                YaoQingModel *model = [[YaoQingModel alloc]init];
                [model setValuesForKeysWithDictionary:dictionary];
                [self.dataSource addObject:model];

            }
            YaoQingModel *model1 = self.dataSource[0];
            YaoQingModel *model2 = self.dataSource[1];
            YaoQingModel *model3 = self.dataSource[2];
            [headIMG_1 sd_setImageWithURL:[NSURL URLWithString:model1.userLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
            [headIMG_2 sd_setImageWithURL:[NSURL URLWithString:model2.userLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
            [headIMG_3 sd_setImageWithURL:[NSURL URLWithString:model3.userLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
            name_1.text = model1.userNickname;
            name_2.text = model2.userNickname;
            name_3.text = model3.userNickname;
            income_1.text = [NSString stringWithFormat:@"%.0f" ,[model1.acctSum floatValue]/100];
            income_2.text = [NSString stringWithFormat:@"%.0f" ,[model2.acctSum floatValue]/100];
            income_3.text = [NSString stringWithFormat:@"%.0f" ,[model3.acctSum floatValue]/100];
        }
        [friendsList reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - 创建list
- (void)addFriendsList{
    friendsList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    friendsList.tableHeaderView = [self creatHeaderView];
    friendsList.backgroundColor = [UIColor whiteColor];
    friendsList.delegate = self;
    friendsList.dataSource = self;
    [self.view addSubview:friendsList];
    [friendsList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    //设置分割线
    if ([friendsList respondsToSelector:@selector(setSeparatorInset:)]) {
        [friendsList setSeparatorInset:UIEdgeInsetsMake(0, 50*WIDTH, 0, 0)];
    }
    [friendsList setSeparatorColor:LYColor_A6];
    
}
#pragma mark 头部视图
- (UIView *)creatHeaderView{
    UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375*WIDTH, 941.5*HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.image = [UIImage imageNamed:@"yaoqinghaoyou-erweima"];
    view.userInteractionEnabled = YES;
    //奖励规则按钮
    UIButton *rewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rewardBtn.backgroundColor = [UIColor colorWithRed:152/255.0 green:154/255.0 blue:153/255.0 alpha:1.0f];
    [rewardBtn setTitle:@"查看奖励规则" forState:UIControlStateNormal];
    [rewardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rewardBtn.titleLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
    [rewardBtn addTarget:self action:@selector(rewardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rewardBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 8*WIDTH, 0, 0);
    [view addSubview:rewardBtn];
    [rewardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18*HEIGHT);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(93*WIDTH, 27*HEIGHT));
    }];
    [rewardBtn layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rewardBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(13.5*HEIGHT, 13.5*HEIGHT)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rewardBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    rewardBtn.layer.mask = maskLayer;
    //邀请好友按钮
    UIImageView *inviteIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anniu-yaoqing"]];
    inviteIMG.contentMode = UIViewContentModeScaleAspectFit;
    inviteIMG.userInteractionEnabled = YES;
    [view addSubview:inviteIMG];
    [inviteIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(347*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(305*WIDTH, 67*HEIGHT));
    }];
    [inviteIMG layoutIfNeeded];
    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [inviteBtn setTitle:@"去邀请好友" forState:UIControlStateNormal];
    [inviteBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
    inviteBtn.titleLabel.font = [UIFont systemFontOfSize:27*HEIGHT];
    [inviteBtn addTarget:self action:@selector(inviteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [inviteIMG addSubview:inviteBtn];
    [inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(inviteIMG);
        make.centerY.mas_equalTo(-3*HEIGHT);
        make.size.mas_equalTo(inviteIMG);
    }];
    //成功邀请 、 累计收益
    UIImageView *IMG_first = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yaoqing-renshu"]];
    IMG_first.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:IMG_first];
    [IMG_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35*WIDTH);
        make.top.mas_equalTo(inviteIMG.mas_bottom).offset(44*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(24*WIDTH, 27*HEIGHT));
    }];
    UILabel *lab_first = [[UILabel alloc]init];
    lab_first.text = @"成功邀请";
    lab_first.font = [UIFont systemFontOfSize:15*HEIGHT];
    lab_first.textColor = [UIColor colorWithRed:213/255.0 green:245/255.0 blue:233/255.0 alpha:1.0];
    [view addSubview:lab_first];
    [lab_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(IMG_first).offset(-4.5*HEIGHT);
        make.left.mas_equalTo(IMG_first.mas_right).offset(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(62*WIDTH, 15*HEIGHT));
    }];
    UILabel *lab_second = [[UILabel alloc]init];
    lab_second.text = @"累计收益";
    lab_second.font = [UIFont systemFontOfSize:15*HEIGHT];
    lab_second.textColor = [UIColor colorWithRed:213/255.0 green:245/255.0 blue:233/255.0 alpha:1.0];
    lab_second.textAlignment = NSTextAlignmentRight;
    [view addSubview:lab_second];
    [lab_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab_first);
        make.right.mas_equalTo(-35*WIDTH);
//        make.height.mas_equalTo(15*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(62*WIDTH, 15*HEIGHT));
    }];
//    [lab_second setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    UIImageView *IMG_second = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yaoqing-shouyi"]];
    IMG_second.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:IMG_second];
    [IMG_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lab_second.mas_left).offset(-18*WIDTH);
        make.top.mas_equalTo(inviteIMG.mas_bottom).offset(44*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(24*WIDTH, 27*HEIGHT));
    }];
    successCount = [[UILabel alloc]init];
//    successCount.text = @"2876位";
    successCount.textAlignment = NSTextAlignmentCenter;
    successCount.font = [UIFont systemFontOfSize:15*HEIGHT];
    successCount.textColor = [UIColor colorWithRed:213/255.0 green:245/255.0 blue:233/255.0 alpha:1.0];
    [view addSubview:successCount];
    [successCount mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(lab_first);
        make.centerX.mas_equalTo(lab_first);
        make.top.mas_equalTo(lab_first.mas_bottom).offset(6*HEIGHT);
//        make.height.mas_equalTo(15*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(90*WIDTH, 15*HEIGHT));
    }];
    [successCount setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    totalIncome = [[UILabel alloc]init];
//    totalIncome.text = @"388.00元";
    totalIncome.textAlignment = NSTextAlignmentCenter;
    totalIncome.font = [UIFont systemFontOfSize:15*HEIGHT];
    totalIncome.textColor = [UIColor colorWithRed:213/255.0 green:245/255.0 blue:233/255.0 alpha:1.0];
    totalIncome.textAlignment = NSTextAlignmentCenter;
    [view addSubview:totalIncome];
    [totalIncome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(successCount);
        make.centerX.mas_equalTo(lab_second);
        make.size.mas_equalTo(successCount);
//        make.right.mas_equalTo(-35*WIDTH);
//        make.height.mas_equalTo(15*HEIGHT);
    }];
    [totalIncome setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //前三名好友
    [self addTop_3ToView:view];
    return view;
}
//前三名好友
- (void)addTop_3ToView:(UIView *)view{
    //背景板
    UIImageView *backgrond_top3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yaoqinghaoyou-top3"]];
    backgrond_top3.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:backgrond_top3];
    [backgrond_top3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.bottom.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(355*WIDTH, 175*HEIGHT));
    }];
    //头像
    headIMG_1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1747a273642419f123202418802d148c.jpg"]];
    [backgrond_top3 addSubview:headIMG_1];
    headIMG_1.layer.cornerRadius = 35*WIDTH;
    headIMG_1.clipsToBounds = YES;
    [headIMG_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15*HEIGHT);
        make.centerX.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(70*WIDTH, 70*WIDTH));
    }];
    headIMG_2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"47d6a96226b32974c6a0b459fa915243.jpg"]];
    [backgrond_top3 addSubview:headIMG_2];
    headIMG_2.layer.cornerRadius = 25*WIDTH;
    headIMG_2.clipsToBounds = YES;
    [headIMG_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headIMG_1);
        make.left.mas_equalTo(34*WIDTH);
        make.size.mas_equalTo(CGSizeMake(50*WIDTH, 50*WIDTH));
    }];
    headIMG_3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2084d39a7af1ff4154531940227a8023.jpg"]];
    [backgrond_top3 addSubview:headIMG_3];
    headIMG_3.layer.cornerRadius = 25*WIDTH;
    headIMG_3.clipsToBounds = YES;
    [headIMG_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headIMG_1);
        make.right.mas_equalTo(-34*WIDTH);
        make.size.mas_equalTo(CGSizeMake(50*WIDTH, 50*WIDTH));
    }];
    //排名标识
    UIImageView *top_1IMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yaoqing-1"]];
    top_1IMG.contentMode = UIViewContentModeScaleAspectFit;
    [backgrond_top3 addSubview:top_1IMG];
    [top_1IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64*HEIGHT);
        make.left.mas_equalTo(145*WIDTH);
        make.size.mas_equalTo(CGSizeMake(22*WIDTH, 28*HEIGHT));
    }];
    UIImageView *top_2IMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yaoqing-2"]];
    top_2IMG.contentMode = UIViewContentModeScaleAspectFit;
    [backgrond_top3 addSubview:top_2IMG];
    [top_2IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64*HEIGHT);
        make.left.mas_equalTo(28*WIDTH);
        make.size.mas_equalTo(CGSizeMake(22*WIDTH, 28*HEIGHT));
    }];
    UIImageView *top_3IMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yaoqing-3"]];
    top_3IMG.contentMode = UIViewContentModeScaleAspectFit;
    [backgrond_top3 addSubview:top_3IMG];
    [top_3IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64*HEIGHT);
        make.left.mas_equalTo(265*WIDTH);
        make.size.mas_equalTo(CGSizeMake(22*WIDTH, 28*HEIGHT));
    }];
    //姓名
    name_1 = [[UILabel alloc]init];
    name_1.font = [UIFont systemFontOfSize:14*HEIGHT];
    name_1.text = @"陶华碧";
    name_1.textColor = LYColor_A3;
    [backgrond_top3 addSubview:name_1];
    [name_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headIMG_1);
        make.top.mas_equalTo(headIMG_1.mas_bottom).offset(11*HEIGHT);
        make.height.mas_equalTo(16*HEIGHT);
    }];
    [name_1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    name_2 = [[UILabel alloc]init];
    name_2.font = [UIFont systemFontOfSize:14*HEIGHT];
    name_2.textColor = LYColor_A3;
    name_2.text = @"AngelaBaby";
    [backgrond_top3 addSubview:name_2];
    [name_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headIMG_2);
        make.top.mas_equalTo(headIMG_2.mas_bottom).offset(11*HEIGHT);
        make.height.mas_equalTo(16*HEIGHT);
    }];
    [name_2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    name_3 = [[UILabel alloc]init];
    name_3.font = [UIFont systemFontOfSize:14*HEIGHT];
    name_3.text = @"刘亦菲";
    name_3.textColor = LYColor_A3;
    [backgrond_top3 addSubview:name_3];
    [name_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headIMG_3);
        make.top.mas_equalTo(headIMG_3.mas_bottom).offset(11*HEIGHT);
        make.height.mas_equalTo(16*HEIGHT);
    }];
    [name_3 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //收入
    income_1 = [[UILabel alloc]init];
    income_1.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:89/255.0 alpha:1.0];
    income_1.text = @"28890";
    income_1.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
    [backgrond_top3 addSubview:income_1];
    [income_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(name_1);
        make.top.mas_equalTo(name_1.mas_bottom).offset(13*HEIGHT);
        make.height.mas_equalTo(14*HEIGHT);
    }];
    [income_1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    income_2 = [[UILabel alloc]init];
    income_2.textColor = [UIColor blackColor];
    income_2.text = @"18290";
    income_2.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
    [backgrond_top3 addSubview:income_2];
    [income_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(name_2);
        make.top.mas_equalTo(name_1.mas_bottom).offset(13*HEIGHT);
        make.height.mas_equalTo(14*HEIGHT);
    }];
    [income_2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    income_3 = [[UILabel alloc]init];
    income_3.textColor = [UIColor blackColor];
    income_3.text = @"18290";
    income_3.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
    [backgrond_top3 addSubview:income_3];
    [income_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(name_3);
        make.top.mas_equalTo(name_1.mas_bottom).offset(13*HEIGHT);
        make.height.mas_equalTo(14*HEIGHT);
    }];
    [income_3 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //"推荐收入(元)"
    for (int i = 0; i < 3; i ++) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"推荐收入(元)";
        lab.font = [UIFont systemFontOfSize:11*HEIGHT];
        lab.textColor = [UIColor grayColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [backgrond_top3 addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-16*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(80*WIDTH, 11*HEIGHT));
        }];
        if (i == 0) {
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(headIMG_1);
                
            }];
        }else if (i == 1) {
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(headIMG_2);
            }];
        }else if (i == 2){
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(headIMG_3);
            }];
        }
    }
    
}
- (void)rewardBtnAction:(UIButton *)sender{
    NSLog(@"奖励规则");
}
- (void)inviteBtnAction:(UIButton *)sender{
    NSLog(@"邀请好友");
}
#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count - 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68*HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.number.text = [NSString stringWithFormat:@"#%ld", indexPath.row + 4];
//    cell.headIMG.image = [UIImage imageNamed:@"timg.jpeg"];
//    cell.name.text = @"加藤鹰";
//    cell.income.text = @"900";
    cell.yaoQingModel = self.dataSource[indexPath.row + 3];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == friendsList) {
        if (scrollView.contentOffset.y < 0) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }
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
