//
//  RenZhengViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "RenZhengViewController.h"
#import "Header.h"
#import "ShenfenzhengHaoViewController.h"
@interface RenZhengViewController ()
@property (nonatomic, strong)UIView *renzhengView;
@property (nonatomic, strong)UIView *wanshanView;
@property (nonatomic, strong)UILabel *shuoming;
@property (nonatomic, strong)UIImageView *zhengmian;
@property (nonatomic, strong)UIImageView *fanmian;
@property (nonatomic, strong)UIButton *nextBtn;
@end

@implementation RenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"实名认证";
    [self renzheng];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeView) name:@"changeView" object:nil];
}
- (void)changeView{
    if (self.renzhengView) {
        [self.renzhengView removeFromSuperview];
        [self wanshan];
    }
}
/**
 添加已经完善页面
 */
- (void)wanshan{
    self.wanshanView = [[UIView alloc]init];
    self.wanshanView.backgroundColor = LYColor_A7;
    [self.view addSubview:self.wanshanView];
    [self.wanshanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UIImageView *myIMGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenfenxinxiyiwanshan.png"]];
    myIMGView.backgroundColor = LYColor_A7;
    myIMGView.contentMode = UIViewContentModeScaleAspectFit;
    [self.wanshanView addSubview:myIMGView];
    [myIMGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.right.mas_equalTo(0);
        make.height.mas_equalTo(193*HEIGHT);
    }];
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.wanshanView addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myIMGView.mas_bottom).with.offset(20*HEIGHT);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(110*HEIGHT);
    }];
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = LYColor_A7;
    [background addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54.5*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    UILabel *nameLable = [[UILabel alloc]init];
    nameLable.text = @"姓名";
    nameLable.textColor = LYColor_A4;
    nameLable.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.centerY.mas_equalTo(-27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];
    UILabel *shenfenzhengHaoLabel = [[UILabel alloc]init];
    shenfenzhengHaoLabel.text = @"身份证号";
    shenfenzhengHaoLabel.textColor = LYColor_A4;
    shenfenzhengHaoLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    [background addSubview:shenfenzhengHaoLabel];
    [shenfenzhengHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.centerY.mas_equalTo(27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    UILabel *name = [[UILabel alloc]init];
    NSString *nameString = @"李关键";
    if (nameString.length > 1) {
        NSRange range = NSMakeRange(1, nameString.length - 1);
        NSString *xingString = @"*";
        for (NSInteger i = 0; i < nameString.length - 2; i ++) {
            xingString = [xingString stringByAppendingString:@"*"];
        }
        name.text = [nameString stringByReplacingOccurrencesOfString:[nameString substringWithRange:range] withString:xingString];
    }else{
        name.text = nameString;
    }
    name.textColor = LYColor_A5;
    name.font = [UIFont systemFontOfSize:13*HEIGHT];
    name.backgroundColor = [UIColor whiteColor];
    name.textAlignment = NSTextAlignmentRight;
    [background addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(-27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];

    UILabel *shenfenzheng = [[UILabel alloc]init];
    NSString *string = @"430902199908061218";
    shenfenzheng.text = [string stringByReplacingOccurrencesOfString:[string substringWithRange:NSMakeRange(1,16)]withString:@"***************"];
    shenfenzheng.textColor = LYColor_A5;
    shenfenzheng.font = [UIFont systemFontOfSize:13*HEIGHT];
    shenfenzheng.backgroundColor = [UIColor whiteColor];
    shenfenzheng.textAlignment = NSTextAlignmentRight;
    [background addSubview:shenfenzheng];
    [shenfenzheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 14*HEIGHT));
    }];
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor whiteColor];
    [self.wanshanView addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(background.mas_bottom).with.offset(13*HEIGHT);
        make.height.mas_equalTo(55*HEIGHT);
    }];
    UILabel *zhengjianshangchuan = [[UILabel alloc]init];
    zhengjianshangchuan.backgroundColor = [UIColor whiteColor];
    zhengjianshangchuan.text = @"证件上传";
    zhengjianshangchuan.font = [UIFont systemFontOfSize:14*HEIGHT];
    zhengjianshangchuan.textColor = LYColor_A4;
    [footView addSubview:zhengjianshangchuan];
    [zhengjianshangchuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.centerY.mas_equalTo(footView);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    UILabel *yishangchaun = [[UILabel alloc]init];
    yishangchaun.text = @"已上传";
    yishangchaun.textColor = LYColor_A3;
    yishangchaun.font = [UIFont systemFontOfSize:14*HEIGHT];
    yishangchaun.backgroundColor = [UIColor whiteColor];
    yishangchaun.textAlignment = NSTextAlignmentRight;
    [footView addSubview:yishangchaun];
    [yishangchaun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(footView);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 14*HEIGHT));
    }];

}
/**
 添加认证界面
 */
- (void)renzheng{
    self.renzhengView = [[UIView alloc]init];
    self.renzhengView.backgroundColor = LYColor_A7;
    [self.view addSubview:self.renzhengView];
    [self.renzhengView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.renzhengView addSubview:self.shuoming];
    [self.renzhengView addSubview:self.zhengmian];
    [self.renzhengView addSubview:self.fanmian];
    [self.shuoming mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22*HEIGHT);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(14*HEIGHT);
        make.width.mas_equalTo(300*WIDTH);
    }];
    [self.zhengmian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shuoming.mas_bottom).with.offset(22*HEIGHT);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(280*WIDTH, 190*HEIGHT));
    }];
    [self.fanmian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zhengmian.mas_bottom).with.offset(9*HEIGHT);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(280*WIDTH, 190*HEIGHT));
    }];
    UIImageView *photo1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiangji-shenfenzheng.png"]];
    photo1.backgroundColor = [UIColor clearColor];
    photo1.contentMode = UIViewContentModeScaleAspectFit;
    [self.zhengmian addSubview:photo1];
    
    UIImageView *photo2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiangji-shenfenzheng.png"]];
    photo2.backgroundColor = [UIColor clearColor];
    photo2.contentMode = UIViewContentModeScaleAspectFit;
    [self.fanmian addSubview:photo2];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"请拍摄身份证正面";
    label1.textColor = LYColor_A3;
    label1.font = [UIFont systemFontOfSize:14*HEIGHT];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.zhengmian addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"请拍摄身份证反面";
    label2.textColor = LYColor_A3;
    label2.font = [UIFont systemFontOfSize:14*HEIGHT];
    label2.textAlignment = NSTextAlignmentCenter;
    [self.fanmian addSubview:label2];
    
    [photo1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.zhengmian);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 60*WIDTH));
    }];
    [photo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.fanmian);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 60*WIDTH));
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(photo1.mas_bottom).with.offset(18*HEIGHT);
        make.centerX.mas_equalTo(self.zhengmian);
        make.size.mas_equalTo(CGSizeMake(140*WIDTH, 15*HEIGHT));
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(photo2.mas_bottom).with.offset(18*HEIGHT);
        make.centerX.mas_equalTo(self.fanmian);
        make.size.mas_equalTo(CGSizeMake(140*WIDTH, 15*HEIGHT));
    }];
    UITapGestureRecognizer *getZhengmian = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getShenFenZhengPhoto:)];
    UITapGestureRecognizer *getFanmian = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getShenFenZhengPhoto:)];
    [self.zhengmian addGestureRecognizer:getZhengmian];
    [self.fanmian addGestureRecognizer:getFanmian];
    
    [self.renzhengView addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fanmian.mas_bottom).with.offset(31*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.right.mas_equalTo(-18*WIDTH);
        make.height.mas_equalTo(44*HEIGHT);
    }];
}

- (void)getShenFenZhengPhoto:(UITapGestureRecognizer *)sender{
    if (sender.view == self.zhengmian) {
        NSLog(@"云脉识别正面");
    }else{
        NSLog(@"云脉识别反面");
    }
}
- (void)pushToShenfenzhengHaoVC:(UIButton *)sender{
    ShenfenzhengHaoViewController *shenfenzhengHaoVC = [[ShenfenzhengHaoViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shenfenzhengHaoVC animated:YES];
}
- (UILabel *)shuoming{
    if (!_shuoming) {
        _shuoming = [[UILabel alloc]init];
        _shuoming.text = @"请拍摄您的身份证反面，用于实名认证";
        _shuoming.textColor = LYColor_A4;
        _shuoming.font = [UIFont systemFontOfSize:12*HEIGHT];
        _shuoming.textAlignment = NSTextAlignmentCenter;
    }
    return _shuoming;
}
- (UIImageView *)zhengmian{
    if (!_zhengmian) {
        _zhengmian = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenfenzhengzhengmian.png"]];
        _zhengmian.backgroundColor = LYColor_A7;
        _zhengmian.contentMode = UIViewContentModeScaleAspectFit;
        _zhengmian.userInteractionEnabled = YES;
    }
    return _zhengmian;
}
- (UIImageView *)fanmian{
    if (!_fanmian) {
        _fanmian = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenfenzhengfanmian.png"]];
        _fanmian.backgroundColor = LYColor_A7;
        _fanmian.contentMode = UIViewContentModeScaleAspectFit;
        _fanmian.userInteractionEnabled = YES;
    }
    return _fanmian;
}
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.backgroundColor = LYColor_A1;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 4.0f;
        [_nextBtn addTarget:self action:@selector(pushToShenfenzhengHaoVC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
/**
 注销通知
 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
