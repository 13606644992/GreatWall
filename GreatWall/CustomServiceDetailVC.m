//
//  CustomServiceDetailVC.m
//  GreatWall
//
//  Created by GJ on 2017/2/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CustomServiceDetailVC.h"
#import "Header.h"
@interface CustomServiceDetailVC ()

@end

@implementation CustomServiceDetailVC
{
    UIView *background;
    UIImageView *titleIMG;
    UIImageView *goodIMG;
    UIImageView *badIMG;
    UILabel *good;
    UILabel *bad;
    UIButton *goodBtn;
    UIButton *badBtn;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
    self.navigationController.navigationBar.translucent = NO;
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
    background = [[UIView alloc]init];
    [self.view addSubview:background];
//    [background mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(18*HEIGHT);
//        make.left.mas_equalTo(18*HEIGHT);
//        make.right.mas_equalTo(-18*HEIGHT);
//        make.height.mas_equalTo(224*HEIGHT);
//    }];
    background.layer.cornerRadius = 4.0f;
    background.backgroundColor = [UIColor whiteColor];
    titleIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kefu-wenti.png"]];
    [background addSubview:titleIMG];
    [titleIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(20*WIDTH, 20*HEIGHT));
    }];
    self.titleLabel = [[UILabel alloc]init];
   self.titleLabel.textColor = LYColor_A3;
   self.titleLabel.text = @"已经投保成功的保单如何进行查询";
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
    [background addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(titleIMG.mas_right).with.offset(18*WIDTH);
        make.centerY.mas_equalTo(titleIMG);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(19*HEIGHT);
    }];
    UIView *line_first = [[UIView alloc]init];
    line_first.backgroundColor = LYColor_A7;
    [background addSubview:line_first];
    [line_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(24*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    //content

    self.content = [[UILabel alloc]init];
    NSString *text = @"保险事故发生后，可通过以下方式申请理赔：拨打汇保险客服热线4001234567咨询理赔的具体事宜，并提供所需的相关单据和证明文件下方式申请理赔：拨打汇保险客服热线4001234567咨询理赔的具体事宜，并提供所需的相关单据和证明文下方式申请理赔：拨打汇保险客服热线4001234567咨询理赔的具体事宜，并提供所需的相关单据和证明文下方式申请理赔：拨打汇保险客服热线4001234567咨询理赔的具体事宜，并提供所需的相关单据和证明文。";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];;
         NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
      [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
        self.content.attributedText = attributedString;

    self.content.font = [UIFont systemFontOfSize:14.0];
    self.content.numberOfLines = 0;
    self.content.textColor = LYColor_A3;
    self.content.preferredMaxLayoutWidth = 303.0f*WIDTH;
    [self.content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [background addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_first.mas_bottom).with.offset(24*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
    }];
    //横线
    UIView *line_second = [[UIView alloc]init];
    line_second.backgroundColor = LYColor_A7;
    [background addSubview:line_second];
    [line_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.content.mas_bottom).with.offset(18*HEIGHT);
        make.left.and.mas_equalTo(18*WIDTH);
        make.right.and.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(1);
    }];
    //是否对您有帮助
    UILabel *bangzhu = [[UILabel alloc]init];
    bangzhu.text = @"是否对您有帮助";
    bangzhu.textColor = LYColor_A4;
//    bangzhu.backgroundColor = LYColor_A1;
    bangzhu.font = [UIFont systemFontOfSize:14.0f*HEIGHT];
    [bangzhu setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [background addSubview:bangzhu];
    [bangzhu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_second.mas_bottom).with.offset(18*HEIGHT);
        make.left.mas_equalTo(self.content);
        make.height.mas_equalTo(14*HEIGHT);
    }];
    
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18*HEIGHT);
        make.left.mas_equalTo(18*HEIGHT);
        make.right.mas_equalTo(-18*HEIGHT);
        make.bottom.mas_equalTo(bangzhu.mas_bottom).with.offset(18*HEIGHT);
    }];
    //有用
    goodIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kefu-youyong.png"]];
    goodIMG.contentMode = UIViewContentModeScaleAspectFit;
    [background addSubview:goodIMG];
    [goodIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bangzhu);
        make.left.mas_equalTo(bangzhu.mas_right).with.offset(40*WIDTH);
        make.size.mas_equalTo(CGSizeMake(14*WIDTH, 15*HEIGHT));
    }];
    good = [[UILabel alloc]init];
    good.textColor = LYColor_A1;
    good.text = @"有用";
    good.font = [UIFont systemFontOfSize:14*HEIGHT];
    [good setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [background addSubview:good];
    [good mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goodIMG.mas_right).with.offset(8*WIDTH);
        make.centerY.mas_equalTo(goodIMG);
        make.height.mas_equalTo(14*WIDTH);
    }];
    //没用
    badIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kefu-meiyong.png"]];
    badIMG.contentMode = UIViewContentModeScaleAspectFit;
    [background addSubview:badIMG];
    [badIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bangzhu);
        make.left.mas_equalTo(good.mas_right).with.offset(30*WIDTH);
        make.size.mas_equalTo(CGSizeMake(14*WIDTH, 15*HEIGHT));
    }];
    bad = [[UILabel alloc]init];
    bad.textColor = LYColor_A4;
    bad.text = @"没用";
    bad.font = [UIFont systemFontOfSize:14*HEIGHT];
    [bad setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [background addSubview:bad];
    [bad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(badIMG.mas_right).with.offset(8*WIDTH);
        make.centerY.mas_equalTo(goodIMG);
        make.height.mas_equalTo(14*WIDTH);
    }];
//    有用/没用 按钮
    goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goodBtn.tag = 1000;
    [goodBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:goodBtn];
    [goodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goodIMG);
        make.right.mas_equalTo(good);
        make.centerY.mas_equalTo(bangzhu);
        make.height.mas_equalTo(18*HEIGHT);
    }];
    badBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    badBtn.tag = 1001;
    [badBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:badBtn];
    [badBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(badIMG);
        make.right.mas_equalTo(bad);
        make.centerY.mas_equalTo(bangzhu);
        make.height.mas_equalTo(18*HEIGHT);
    }];
}
- (void)btnAction:(UIButton *)sender{
    NSLog(@"%ld", sender.tag);
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
