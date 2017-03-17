//
//  CarNumberController.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/1.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CarNumberController.h"
#import "Header.h"
#import <CoreLocation/CoreLocation.h>
#import "Address.h"
#import "CarMsgController.h"
#import "LocationAddress.h"

@interface CarNumberController ()<CLLocationManagerDelegate>
{
    NSString *areaIdx;
    NSString *shengStr;
    NSString *shiStr;
    NSInteger index;
}
 @property (nonatomic, strong) CLLocationManager* locationManager;
/*
 *  shengModel
 */
@property (nonatomic ,strong) CarNumberModel *shengModel;
/*
 *  shiModel
 */
@property (nonatomic ,strong) CarNumberModel *shiModel;
@property (nonatomic ,strong) UIView *whiteView;
@property (nonatomic ,strong) UIImageView *titleImg;
@property (nonatomic ,strong) UIImageView *areaImg;
@property (nonatomic ,strong) UIButton *searchBtn;
@property (nonatomic ,strong) UILabel *touLab;
@property (nonatomic ,strong) UILabel *carLab;
@property (nonatomic ,strong) UILabel *touarea;
@property (nonatomic ,strong) UITextField *carNumber;
@property (nonatomic ,strong) UIImageView *carImg;
@property (nonatomic ,strong) UILabel *carTypeLab;
@property (nonatomic ,strong) UIButton *typeBtn;
@property (nonatomic ,strong) UIButton *areaBtn;
@property (nonatomic ,strong) UIButton *historyBtn;
@property (nonatomic ,strong) UILabel *line1;
@property (nonatomic ,strong) UILabel *line2;
@end

@implementation CarNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"平安车险";
//    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    self.view.backgroundColor = LYColor_A7;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[LYColor colorWithHexString:@"#2dce8f"]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 10, 17.5);
    [backBtn addTarget:self action:@selector(CarbackClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [self setTheCarNumberSelect];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.title = self.insureName;
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    [manager stopUpdatingLocation];
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        index = 0;
        
        if (error) {
            
        }else{
            for (CLPlacemark *place in placemarks) {
                index++;
                if (index == 1) {
                    self.touarea.text = place.locality;
                    shiStr = place.locality;
                    shengStr = place.administrativeArea;
                    CGRect tempRect = [self.touarea.text  boundingRectWithSize:CGSizeMake(150*WEIGHT,13*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*HEIGHT]}context:nil];
                    [self.touarea mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.width.equalTo(@(tempRect.size.width+3));
                    }];
                    [DataGreatWall PostTheAddressWithTheCompanyCode:self.insurerId WithTheAreaCode:@"0" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
                        if (error) {
                        }else if ([respCode isEqualToString:@"000000"]){
                            for (CarNumberModel *model in array) {
                                if ([model.areaName isEqualToString:shengStr]) {
                                    self.shengModel = model;
                                    [self setTheCarNumberWithCode:model.areaCode WithCity:shiStr];
                                    return;
                                }
                            }
                        }else{
                            
                        }
                    }];
                }
                
            }
           
        }
    }];
}
-(void)setTheCarNumberWithCode:(NSString *)code WithCity:(NSString *)city{
    [DataGreatWall PostTheAddressWithTheCompanyCode:self.insurerId WithTheAreaCode:code WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
        if (error) {
            
        }else if ([respCode isEqualToString:@"000000"]){
            
            for (CarNumberModel *model in array) {
                
                if ([model.areaName isEqualToString:city]) {

                    areaIdx = model.areaCode;
                    
                    self.carNumber.text = model.licensePreff;
                    
                }
            }
           
        }else{
            
        }

    }];

}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}
-(void)setTheCarNumberSelect
{
    [self.view addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(64));
        make.height.equalTo(@(291*HEIGHT+2));
    }];
    [self.whiteView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.whiteView);
        make.height.equalTo(@(113*HEIGHT));
    }];
    [self.whiteView addSubview:self.touLab];
    [self.touLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.titleImg.mas_bottom).with.offset(32*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];
    [self.whiteView addSubview:self.touarea];
    [self.touarea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(125*WIDTH));
        make.centerY.equalTo(self.touLab);
        make.width.equalTo(@(43*WIDTH));
        make.height.equalTo(@(13*HEIGHT));
    }];
    [self.whiteView addSubview:self.areaImg];
    [self.areaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.touarea.mas_right).with.offset(5*WIDTH);
        make.centerY.equalTo(self.touarea);
        make.size.mas_equalTo(CGSizeMake(11*WIDTH, 14*HEIGHT));
    }];
    [self.whiteView addSubview:self.areaBtn];
    [self.areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.touarea);
        make.right.equalTo(self.areaImg);
        make.height.equalTo(@(30*HEIGHT));
    }];
    [self.whiteView addSubview:self.line1];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.touLab.mas_bottom).with.offset(21*HEIGHT);
        make.right.equalTo(self.whiteView);
        make.height.equalTo(@(0.5));
    }];
    [self.whiteView addSubview:self.carLab];
    [self.carLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.line1.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];
    [self.whiteView addSubview:self.carNumber];
    [self.carNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(125*WIDTH));
        make.centerY.equalTo(self.carLab);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(13*HEIGHT));
    }];
    [self.whiteView addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.carLab.mas_bottom).with.offset(21*HEIGHT);
        make.right.equalTo(self.whiteView);
        make.height.equalTo(@(0.5));
    }];
    [self.whiteView addSubview:self.carImg];
    [self.carImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.line2.mas_bottom).with.offset(19*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(19*WIDTH, 19*WIDTH));
    }];
    [self.whiteView addSubview:self.carTypeLab];
    [self.carTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.carImg.mas_right).with.offset(11*WIDTH);
        make.centerY.equalTo(self.carImg);
        make.size.mas_equalTo(CGSizeMake(75*WIDTH, 14*HEIGHT));
    }];
    [self.whiteView addSubview:self.typeBtn];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.line2.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 56*HEIGHT));
    }];
    [self.whiteView addSubview:self.historyBtn];
    [self.historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.carImg);
        make.size.mas_equalTo(CGSizeMake(110*WIDTH, 30*HEIGHT));
    }];
    [self.view addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.right.equalTo(@(-18*WIDTH));
        make.top.mas_equalTo(self.whiteView.mas_bottom).with.offset(31*HEIGHT);
        make.height.equalTo(@(44*HEIGHT));
    }];
}
-(void)carTypeClick:(UIButton *)sender
{
    if (sender.selected == YES) {
        sender.selected = NO;
        self.carImg.image = [UIImage imageNamed:@"gouxuanxincheweishangpai"];
    }else{
        sender.selected = YES;
        self.carImg.image = [UIImage imageNamed:@"weigouxuan(xincheweishangpai)"];
    }
}


-(void)selectAddress:(UIButton *)sender
{
    [[LocationAddress shareShareType] AddressSelectShowModeWithinsureId:self.insurerId];
    [[LocationAddress shareShareType] LYShareTypeBackSelectBlock:^(NSString * address,NSString *shi,NSString *qu,NSString *areaId) {
        self.carNumber.text = areaId;
        self.touarea.text = shi;
        shiStr = shi;
    }];


}

-(void)historyClick:(UIButton *)sender
{
    
}
-(void)CarbackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchClick
{
    [DataGreatWall PostTheCarWithTheChEckMsgWithcompanyCode:self.insurerId WithAreaCode:areaIdx WithThelicenseNo:self.carNumber.text WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
        if (error) {
            
        }else if ([respCode isEqualToString:@"000000"]){
            if ([pageSize isEqualToString:@"-1"]) {
                SVProgress(@"该车辆不能投保");
            }else if ([pageSize isEqualToString:@"1"]){
                self.hidesBottomBarWhenPushed=YES;
                CarMsgController *baseVC = [[CarMsgController alloc] init];
                baseVC.serialId = totalCount;
                [self.navigationController pushViewController:baseVC animated:YES];
            }else if ([pageSize isEqualToString:@"0"]){
                self.hidesBottomBarWhenPushed=YES;
                CarMsgController *baseVC = [[CarMsgController alloc] init];
                baseVC.serialId = totalCount;
                [self.navigationController pushViewController:baseVC animated:YES];
            }
        }else{
            
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----Controller----------
-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
-(UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"carbanner"]];
    }
    return _titleImg;
}
-(UILabel *)touLab{
    if (!_touLab) {
        _touLab = [[UILabel alloc] init];
        _touLab.textColor = LYColor_A4;
        _touLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _touLab.text = @"投保城市";
    }
    return _touLab;
}
-(UILabel *)touarea{
    if (!_touarea) {
        _touarea = [[UILabel alloc] init];
        _touarea.textColor = LYColor_A3;
        _touarea.font = [UIFont systemFontOfSize:13*WIDTH];
        _touarea.text = @"杭州市";
    }
    return _touarea;
}
-(UIImageView *)areaImg{
    if (!_areaImg) {
        _areaImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dingwei"]];
    }
    return _areaImg;
}
-(UILabel *)carLab{
    if (!_carLab) {
        _carLab = [[UILabel alloc] init];
        _carLab.textColor = LYColor_A4;
        _carLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _carLab.text = @"车牌号码";
    }
    return _carLab;
}
-(UITextField *)carNumber{
    if (!_carNumber) {
        _carNumber = [[UITextField alloc] init];
        _carNumber.placeholder = @"请输入车牌号码";
        _carNumber.font = [UIFont systemFontOfSize:14*WIDTH];
        _carNumber.textColor = LYColor_A3;
    }
    return _carNumber;
}
-(UIImageView *)carImg{
    if (!_carImg) {
        _carImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weigouxuan(xincheweishangpai)"]];
    }
    return _carImg;
}
-(UILabel *)carTypeLab
{
    if (!_carTypeLab) {
        _carTypeLab = [[UILabel alloc] init];
        _carTypeLab.textColor = LYColor_A1;
        _carTypeLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _carTypeLab.text = @"新车未上牌";
    }
    return _carTypeLab;
}
-(UIButton *)typeBtn{
    if (!_typeBtn) {
        _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeBtn addTarget:self action:@selector(carTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        _typeBtn.selected = NO;
    }
    return _typeBtn;
}
-(UIButton *)areaBtn{
    if (!_areaBtn) {
        _areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_areaBtn addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
        _areaBtn.selected = NO;
    }
    return _areaBtn;
}
-(UIButton *)historyBtn
{
    if (!_historyBtn) {
        _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_historyBtn setTitle:@"历史查询车辆" forState:UIControlStateNormal];
        _historyBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
        [_historyBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        [_historyBtn addTarget:self action:@selector(historyClick:) forControlEvents:UIControlEventTouchUpInside];
        _historyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _historyBtn;
}
-(UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_searchBtn setTitle:@"查询" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH];
        [_searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.backgroundColor = LYColor_A1;
        _searchBtn.layer.cornerRadius = 4.0f;
        _searchBtn.clipsToBounds = YES;
    }
    return _searchBtn;
}
-(UILabel *)line1
{
    if (!_line1) {
        _line1 = [[UILabel alloc] init];
        _line1.backgroundColor = LYColor_A6;
    }
    return _line1;
}
-(UILabel *)line2
{
    if (!_line2) {
        _line2 = [[UILabel alloc] init];
        _line2.backgroundColor = LYColor_A6;
    }
    return _line2;
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
