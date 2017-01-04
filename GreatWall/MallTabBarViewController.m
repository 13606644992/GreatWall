//
//  MallTabBarViewController.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/29.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "MallTabBarViewController.h"
#import "MMHeader.h"
#import "ViewController.h"
#import "MallViewController.h"
#import "SearchController.h"
#import "CarMallViewController.h"

static NSString *cellID = @"MMCell";
@interface MallTabBarViewController ()<MMTabBarViewDataSource, MMTabBarViewDelegate>
{
    NSInteger indexPathSelect;
    UIImageView *navBarHairlineImageView;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end
@implementation  MallTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    indexPathSelect = 0;
    self.title=@"商城";

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[LYColor colorWithHexString:@"#2dce8f"]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIView * msgView= [[UIView alloc] initWithFrame:CGRectMake(0 ,0 ,17 ,17)];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"sousuo(shancgheng)"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0,0,17, 17);
    [searchBtn addTarget:self action:@selector(searchButtonOnClicked) forControlEvents:UIControlEventTouchDown];
    [msgView addSubview:searchBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:msgView];

    [self initMehod];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-1, self.navigationController.navigationBar.frame.size.width, 0.5)];
    line.backgroundColor = [LYColor colorWithHexString:@"#e3e3e3"];
    [self.navigationController.navigationBar addSubview:line];
    [self.navigationController.navigationBar bringSubviewToFront:line];

}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];

}

-(void)searchButtonOnClicked
{
    self.hidesBottomBarWhenPushed=YES;
    SearchController *baseVC = [[SearchController alloc] init];
    [self.navigationController pushViewController:baseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)initMehod{
    self.dataSource = self;
    self.delegate = self;
    //指定样式
    self.gradientType = MMTabBarViewGradientTypeUnderline;
    [self reload];    
}
#pragma mark - MMTabBarViewDataSource----------
- (NSArray *)infomationsForViewController:(MMTabBarViewController *)tabBarViewController{
    return [self.dataArr copy];
}
- (NSUInteger )numberOfItemsInViewController:(MMTabBarViewController *)tabBarViewController {
    return self.dataArr.count;
}
- (MMTabBarModel *)infomationInViewController:(MMTabBarViewController *)tabBarViewController infoForItemAtIndex:(NSUInteger)index {
        return self.dataArr[index];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - get

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        NSArray *data = @[@[@"CarMallViewController",@"车险"],@[@"MallViewController",@"理财险"],@[@"MallViewController",@"意外险"],@[@"MallViewController",@"健康险"],@[@"MallViewController",@"旅游险"],@[@"MallViewController",@"少儿险"],@[@"MallViewController",@"责任险"],@[@"MallViewController",@"理财险"],@[@"MallViewController",@"分红险"]];
        
        for (int i = 0; i < data.count; i++) {
            [_dataArr addObject:[MMTabBarModel modelWithControllerClassName:[data[i] firstObject]  controllerTitle:[data[i] lastObject]]];
        }
    }
    return _dataArr;
}



@end
