//
//  HongBaoViewController.m
//  GreatWall
//
//  Created by GJ on 2017/1/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "HongBaoViewController.h"
#import "Header.h"
#import "WeiShiYongVC.h"
#import "ShiYongJiLuVC.h"
#import "YiGuoQiVC.h"
@interface HongBaoViewController ()
@property (nonatomic, strong)UIButton *weishiyongBtn;
@property (nonatomic, strong)UIButton *shiyongjiluBtn;
@property (nonatomic, strong)UIButton *yiguoqiBtn;
@property (nonatomic, strong)UIView *hengXian;
@property (nonatomic, strong)UIScrollView *zoomScrollView;
@property (nonatomic, strong)WeiShiYongVC *weishiyongVC;
@property (nonatomic, strong)ShiYongJiLuVC *shiyongjilyVC;
@property (nonatomic, strong)YiGuoQiVC *yiguoqiVC;
@end

@implementation HongBaoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:LYColor_A1};//导航栏文字颜色及大小
     self.navigationController.navigationBar.translucent = NO;
    StatusBarBlack;
     self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的红包";
    //右上角按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"lvwenhao.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction)];
    rightItem.tintColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0];
    self.navigationItem.rightBarButtonItem = rightItem;
 
    //黑线
    UIView *line_first = [[UIView alloc]init];
    line_first.backgroundColor = LYColor_A6;
    [self.view addSubview:line_first];
    [line_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = UIColorRGBA(250, 250, 250, 1);
    [self.view addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_first.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    //黑线2
    UIView *line_second = [[UIView alloc]init];
    line_second.backgroundColor = LYColor_A6;
    [self.view addSubview:line_second];
    [line_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    //切换按钮
    self.weishiyongNum = @"6";
    self.shiyongjiluNum = @"5";
    self.yiguoqiNum = @"10";

    [background addSubview:self.weishiyongBtn];
    [self.weishiyongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset(- ScreenWindowWidth / 3);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.shiyongjiluBtn];
    [self.shiyongjiluBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
    [background addSubview:self.yiguoqiBtn];
    [self.yiguoqiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background);
        make.centerX.mas_equalTo(background).with.offset( ScreenWindowWidth / 3);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth / 3 - 30, 40*HEIGHT));
    }];
//底部滑动横线
    [background addSubview:self.hengXian];
    [self.hengXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(background);
        make.centerX.mas_equalTo(self.weishiyongBtn);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(55);
    }];

    [self.view layoutIfNeeded];
    
    //大scrollView
    [self.view addSubview:self.zoomScrollView];
    [self.zoomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_second.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.zoomScrollView layoutIfNeeded];
    self.zoomScrollView.contentSize = CGSizeMake(self.zoomScrollView.frame.size.width * 3, 0);
    self.zoomScrollView.delegate = self;
    self.zoomScrollView.showsHorizontalScrollIndicator = NO;
    //添加子试图控制器
    self.weishiyongVC = [[WeiShiYongVC alloc]init];
    [self addChildViewController:self.weishiyongVC];
    [self.weishiyongVC didMoveToParentViewController:self];
    self.weishiyongVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
    [self.zoomScrollView addSubview:self.weishiyongVC.view];
    
    self.shiyongjilyVC = [[ShiYongJiLuVC alloc]init];
    [self addChildViewController:self.shiyongjilyVC];
    [self.shiyongjilyVC didMoveToParentViewController:self];
    self.shiyongjilyVC.view.frame = CGRectMake( ScreenWindowWidth, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
     [self.zoomScrollView addSubview:self.shiyongjilyVC.view];
    
    self.yiguoqiVC = [[YiGuoQiVC alloc]init];
    [self addChildViewController:self.yiguoqiVC];
    [self.yiguoqiVC didMoveToParentViewController:self];
    self.yiguoqiVC.view.frame = CGRectMake( ScreenWindowWidth * 2, 0, self.view.frame.size.width, self.zoomScrollView.frame.size.height);
     [self.zoomScrollView addSubview:self.yiguoqiVC.view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.zoomScrollView) {
        CGFloat bili = (self.zoomScrollView.contentOffset.x + ScreenWindowWidth / 2 ) / self.zoomScrollView.contentSize.width;
        self.hengXian.center = CGPointMake(ScreenWindowWidth * bili, self.hengXian.center.y);
        
    }
}


- (void)selectTheViewOfHongBaoWithButton:(UIButton *)sender{
    [UIView animateWithDuration:0.2 animations:^{
        if (sender.tag == 1000) {
            [self.zoomScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }else if (sender.tag == 1001){
            [self.zoomScrollView setContentOffset:CGPointMake(ScreenWindowWidth, 0) animated:NO];
        }else{
            [self.zoomScrollView setContentOffset:CGPointMake(ScreenWindowWidth * 2, 0) animated:NO];
        }
    }];
    
}

- (void)rightBtnAction{
    NSLog(@"问号");
}





/************懒加载      *******************/
- (UIButton *)weishiyongBtn{
    if (!_weishiyongBtn) {
        _weishiyongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weishiyongBtn.backgroundColor = [UIColor clearColor];
        [_weishiyongBtn setTitle:[NSString stringWithFormat:@"未使用(%@)", self.weishiyongNum] forState:UIControlStateNormal];
        [_weishiyongBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _weishiyongBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_weishiyongBtn addTarget:self action:@selector(selectTheViewOfHongBaoWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _weishiyongBtn.tag = 1000;
    }
    return _weishiyongBtn;
}
- (UIButton *)shiyongjiluBtn{
    if (!_shiyongjiluBtn) {
        _shiyongjiluBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shiyongjiluBtn.backgroundColor = [UIColor clearColor];
        [_shiyongjiluBtn setTitle:[NSString stringWithFormat:@"使用记录(%@)", self.shiyongjiluNum] forState:UIControlStateNormal];
        [_shiyongjiluBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _shiyongjiluBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_shiyongjiluBtn addTarget:self action:@selector(selectTheViewOfHongBaoWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _shiyongjiluBtn.tag = 1001;
    }
    return _shiyongjiluBtn;
}
- (UIButton *)yiguoqiBtn{
    if (!_yiguoqiBtn) {
        _yiguoqiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yiguoqiBtn.backgroundColor = [UIColor clearColor];
        [_yiguoqiBtn setTitle:[NSString stringWithFormat:@"已过期(%@)", self.yiguoqiNum] forState:UIControlStateNormal];
        [_yiguoqiBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        _yiguoqiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_yiguoqiBtn addTarget:self action:@selector(selectTheViewOfHongBaoWithButton:) forControlEvents:UIControlEventTouchUpInside];
        _yiguoqiBtn.tag = 1002;
    }
    return _yiguoqiBtn;
}
- (UIView *)hengXian{
    if (!_hengXian) {
        _hengXian = [[UIView alloc]init];
        _hengXian.backgroundColor = LYColor_A1;

    }
    return _hengXian;
}
- (UIScrollView *)zoomScrollView{
    if (!_zoomScrollView) {
        _zoomScrollView = [[UIScrollView alloc]init];
        _zoomScrollView.backgroundColor = LYColor_A7;

        _zoomScrollView.contentOffset = CGPointMake(0, 0);
        _zoomScrollView.pagingEnabled = YES;
        _zoomScrollView.bounces = NO;
    }
    return _zoomScrollView;
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
