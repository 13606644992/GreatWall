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
#import "DescriptionController.h"
#import "DataGreatWall.h"
#import "SelectController.h"
#import "CarNumberController.h"


static NSString *cellID = @"MMCell";
@interface MallTabBarViewController ()<MMTabBarViewDataSource, MMTabBarViewDelegate>
{
    NSInteger indexPathSelect;
    UIImageView *navBarHairlineImageView;
    UIView *line;
    NSMutableArray *nameArray;
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
//    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[LYColor colorWithHexString:@"#2dce8f"]}];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectSearchClick:) name:@"SelectSearch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(descriptionBtnClick:) name:@"DescriptionVC" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(descriptionCarClick:) name:@"DescriptionCarVC" object:nil];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[LYColor colorWithHexString:@"#2dce8f"]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIView * msgView= [[UIView alloc] initWithFrame:CGRectMake(0 ,0 ,17 ,17)];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"sousuo(shancgheng)"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0,0,17, 17);     
    [searchBtn addTarget:self action:@selector(searchButtonOnClicked) forControlEvents:UIControlEventTouchDown];
    [msgView addSubview:searchBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:msgView];
    line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-1, self.navigationController.navigationBar.frame.size.width, 0.5)];
    line.backgroundColor = [LYColor colorWithHexString:@"#e3e3e3"];
    [self.navigationController.navigationBar addSubview:line];
    [self.navigationController.navigationBar bringSubviewToFront:line];
    [self initMehod];

    [DataGreatWall PostTheProductTypeWithparentId:@"0" WithBlock:^(NSString *respCode, NSString *respMsg, MallProductType *type, NSError *error) {
        if (error) {
            
        }else if ([respCode isEqualToString:@"000000"]){
            __block NSMutableArray *titles = [NSMutableArray arrayWithCapacity:0];
            
            nameArray = [[NSMutableArray alloc] initWithArray:type.typeList];
            [type.typeList enumerateObjectsUsingBlock:^(MallProductType *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                if ([obj.typeName isEqualToString:@"车险"]) {
                    [array addObject:@"CarMallViewController"];
                }else{
                    [array addObject:@"MallViewController"];
                }
                [array addObject:obj.typeName];
                [array addObject:obj.typeId];
                [titles addObject:array];
            }];
            NSMutableArray *arrays = [NSMutableArray arrayWithCapacity:0];
            for (int i = 0; i < titles.count; i++) {
                [arrays addObject:[MMTabBarModel modelWithControllerClassName:[titles[i] firstObject]  controllerTitle:[titles[i] objectAtIndex:1] WithIndexInfo:[titles[i] lastObject]]];
            }
            self.dataArr = arrays;
            [self reload];
            [self mmReloate];
            [self viewWillAppear:YES];
        }else{
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    line.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBarHidden = NO;
    if (self.itemSelect) {
        [self reloateIndexWith:[self.itemSelect integerValue]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Home_index"]) {
        [nameArray enumerateObjectsUsingBlock:^(MallProductType *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Home_index"] isEqualToString:obj.typeName]) {
                [self reloateIndexWith:idx];
                *stop = YES;
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Home_index"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                return;
            }
        }];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    line.hidden = YES;
}
-(void)descriptionBtnClick:(NSNotification *)sender{
//    NSLog(@"%@",sender.userInfo);
    NSDictionary *dic = sender.userInfo;
    self.hidesBottomBarWhenPushed=YES;
    DescriptionController *baseVC = [[DescriptionController alloc] init];
    baseVC.productId = dic[@"DescriptionVC"];
    [self.navigationController pushViewController:baseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)descriptionCarClick:(NSNotification *)sender{
    
    NSDictionary *dic = sender.userInfo;
    self.hidesBottomBarWhenPushed=YES;
    CarNumberController *baseVC = [[CarNumberController alloc] init];
    baseVC.productId = dic[@"productId"];
    baseVC.insureName = dic[@"insurerName"];
    baseVC.insurerId = dic[@"insurerId"];
    [self.navigationController pushViewController:baseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;

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

-(void)selectSearchClick:(NSNotification *)sender
{
    NSLog(@"--%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"index"]);
//    NSDictionary *dic = sender.userInfo;
    self.hidesBottomBarWhenPushed=YES;
    SelectController *baseVC = [[SelectController alloc] init];
//    baseVC.selectItem = dic[@"select"];
    baseVC.selectItem = [[NSUserDefaults standardUserDefaults] objectForKey:@"index"];
    [self.navigationController pushViewController:baseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
    }
    return _dataArr;
}



@end
