//
//  AboutVC.m
//  GreatWall
//
//  Created by GJ on 2017/3/2.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "AboutVC.h"
#import "Header.h"

@interface AboutVC ()

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于汇保险";
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guanyuhuibaoxian@2x"]];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(48*HEIGHT);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(157*WIDTH, 123*HEIGHT));
    }];
    
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:background];
    
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(47*HEIGHT);
        make.height.mas_equalTo(48*3*HEIGHT);
    }];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(17.5 * WIDTH, 49 * HEIGHT, 357.5 * WIDTH, 1)];
    line.backgroundColor = LYColor_A7;
    [background addSubview:line];
    
    UILabel *lineTwo = [[UILabel alloc]initWithFrame:CGRectMake(17.5 * WIDTH, 49 * 2 * HEIGHT, 357.5 * WIDTH, 1)];
    lineTwo.backgroundColor = LYColor_A7;
    [background addSubview:lineTwo];
    
    NSArray *titleArray = @[@"微信公众号",@"官方网站",@"客服电话"];
    NSArray *detailArray = @[@"hbx51hbx",@"http://www.51hbx.com",@"400 - 678 - 6078"];
    for (int i = 0; i < 3; i++) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont systemFontOfSize:14*WIDTH];
        title.textColor = LYColor_A3;
        title.text = titleArray[i];
        [background addSubview:title];
        title.backgroundColor = [UIColor whiteColor];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.top.mas_equalTo((17 + 49 * i)* HEIGHT);
            make.size.mas_equalTo(CGSizeMake(100 * WIDTH, 15 * HEIGHT));
        }];
        
        UILabel *detail = [[UILabel alloc]init];
        detail.font = [UIFont systemFontOfSize:14*WIDTH];
        detail.textColor = UIColorRGBA(88, 151, 255, 1);
        detail.text = detailArray[i];
        [background addSubview:detail];
        detail.backgroundColor = [UIColor whiteColor];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(130*WIDTH);
            make.top.mas_equalTo((17 + 49 * i)* HEIGHT);
            make.size.mas_equalTo(CGSizeMake(180 * WIDTH, 15 * HEIGHT));
        }];
        
        UIImageView *jiantouIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
        jiantouIMG.contentMode = UIViewContentModeScaleAspectFit;
        [background addSubview:jiantouIMG];
        [jiantouIMG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(title);
            make.right.mas_equalTo(-18 * WIDTH);
            make.size.mas_equalTo(CGSizeMake(5.5 * WIDTH, 9.5 * HEIGHT));
        }];
        //按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [background addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(title);
            make.right.mas_equalTo(-5 * WIDTH);
            make.size.mas_equalTo(CGSizeMake(300 * WIDTH, 40 * HEIGHT));
        }];
        btn.alpha = 0.5;
        //        btn.backgroundColor = [UIColor yellowColor];
        //        [btn setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
        btn.tag = i + 1000;
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *bottomGS = [[UILabel alloc]init];
    bottomGS.text = @"浙江保保科技有限公司 版权所有";
    bottomGS.textColor = LYColor_A4;
    bottomGS.textAlignment = NSTextAlignmentCenter;
    bottomGS.font = [UIFont systemFontOfSize:11*HEIGHT];
    [self.view addSubview:bottomGS];
    
    [bottomGS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).offset(192*HEIGHT);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(300, 12*HEIGHT));
    }];
    
    UILabel *bottomDate = [[UILabel alloc]init];
    bottomDate.text = @"Copyright ⓒ 2016-2019";
    bottomDate.textColor = LYColor_A4;
    bottomDate.textAlignment = NSTextAlignmentCenter;
    bottomDate.font = [UIFont systemFontOfSize:11*HEIGHT];
    [self.view addSubview:bottomDate];
    
    [bottomDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomGS.mas_bottom).offset(7*HEIGHT);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(300, 12*HEIGHT));
    }];
}

- (void)btnAction:(UIButton *)sender{
    switch (sender.tag) {
        case 1000:
            NSLog(@"1");
            break;
        case 1001:
            NSLog(@"2");
            break;
        case 1002:
            NSLog(@"3");
            break;
            
        default:
            break;
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
