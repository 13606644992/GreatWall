//
//  LocationAddress.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "LocationAddress.h"
#import "UIView+Frame.h"
#import "Header.h"
#import "AddressCell.h"
#import "AreaModel.h"

@interface LocationAddress ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *areaList;
    NSMutableArray *modelArray;
    UILabel *line;
    NSInteger areaType;
    NSArray *dataArr;
    UIView *underLine;
    AreaModel *shengmodel;
    AreaModel *shimodel;
    
    NSString *shengStr;
}
@property (nonatomic, strong)NSMutableArray *buttonArray;
@property (nonatomic, strong)UIButton *shengBtn;
@property (nonatomic, strong)UIButton *shiBtn;
@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UIView *bgView;
/*
 *  shengArr
 */
@property (nonatomic ,strong) NSMutableArray *provenceArr;
/*
 *  shiArr
 */
@property (nonatomic ,strong) NSMutableArray *cityArr;
/*
 *  tableView
 */
@property (nonatomic ,strong) UITableView *tabView;
/*
 *  insureId
 */
@property (nonatomic ,strong) NSString *insureId;
@end

@implementation LocationAddress
static id _instace;

+ (instancetype)shareShareType{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{// 只创建一次
        _instace = [[self alloc] init];
    });
    return _instace;
}
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{// 只初始化一次
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}

- (void)AddressSelectShowModeWithinsureId:(NSString *)insureId{
    if (!self.background) {
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight-64)];
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.alpha = 0.7;
        
        self.background = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWindowHeight, ScreenWindowWidth, 416*HEIGHT)];
        self.background.backgroundColor = [UIColor whiteColor];
        
        self.background.userInteractionEnabled = YES;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.background.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.background.bounds;
        maskLayer.path = maskPath.CGPath;
        self.background.layer.mask = maskLayer;
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.backgroundColor = [UIColor clearColor];
        [self.background addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(45*WIDTH, 45*WIDTH));
        }];
        [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *backIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shanchu.png"]];
        backIMG.contentMode = UIViewContentModeScaleAspectFit;
        [backBtn addSubview:backIMG];
        [backIMG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(backBtn);
            make.size.mas_equalTo(CGSizeMake(9*WIDTH, 9*WIDTH));
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.text = @"请选择所在地区";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = LYColor_A4;
        titleLabel.font = [UIFont systemFontOfSize:14.0f*WIDTH];
        [self.background addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16*HEIGHT);
            make.centerX.mas_equalTo(self.background);
            make.size.mas_equalTo(CGSizeMake(200*WIDTH, 14*HEIGHT));
        }];
        
        
        line = [[UILabel alloc]init];
        line.backgroundColor = LYColor_A7;
        [self.background addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(90*HEIGHT);
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        //areaType
        areaType = 0;
        //按钮
        self.shengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shengBtn setTitle:@"请选择" forState:UIControlStateNormal];
        self.shengBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
        [self.shengBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        [self.background addSubview:self.shengBtn];
        [self.shengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25*WIDTH);
            make.top.mas_equalTo(50*HEIGHT);
            make.height.mas_equalTo(30*HEIGHT);
            make.width.mas_equalTo(60*WIDTH);
        }];
        [self.shengBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.shengBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.shengBtn.tag = 1000;
        
        self.shiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shiBtn setTitle:@"请选择" forState:UIControlStateNormal];
        self.shiBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
        [self.shiBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        [self.background addSubview:self.shiBtn];
        [self.shiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shengBtn.mas_right).with.offset(15*WIDTH);
            make.top.mas_equalTo(50*HEIGHT);
            make.height.mas_equalTo(30*HEIGHT);
            make.width.mas_equalTo(60*WIDTH);
        }];
        [self.shiBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.shiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.shiBtn.tag = 1002;
        self.shiBtn.hidden = YES;
        self.shiBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        
        self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        [self.background addSubview:self.tabView];
        [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        self.tabView.delegate = self;
        self.tabView.dataSource = self;
        self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.background addSubview:self.tabView];
        
        
        dataArr = [NSArray array];
        modelArray = [NSMutableArray array];
        underLine = [[UIView alloc]init];
        underLine.backgroundColor = LYColor_A4;
        [self.background addSubview:underLine];
        [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.shengBtn);
            make.bottom.mas_equalTo(line.mas_bottom);
            make.height.mas_equalTo(2);
            make.width.mas_equalTo(self.shengBtn);
        }];
        [underLine layoutIfNeeded];
        
        

        
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.bgView];
        [window addSubview:self.background];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.background.y = ScreenWindowHeight - 416*HEIGHT;
        }];
        
        self.insureId = insureId;
        [DataGreatWall PostTheAddressWithTheCompanyCode:insureId WithTheAreaCode:@"0" WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
            if (error) {
            }else if ([respCode isEqualToString:@"000000"]){
                self.provenceArr = [[NSMutableArray alloc] initWithArray:array];
                [self.tabView reloadData];
            }else{
                
            }
        }];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"dataArr ============= %@",self.provenceArr);

    switch (areaType) {
        case 0:
            return self.provenceArr.count;
            break;
        case 1:
            return self.cityArr.count;
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (areaType) {
        case 0:
            dataArr = self.provenceArr;
            break;
        case 1:
            dataArr = self.cityArr;
            break;
        default:
            break;
    }
    CarNumberModel *model = dataArr[indexPath.row];
    cell.area.text = model.areaName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)areaType);
    CGRect rect = underLine.frame;
    switch (areaType) {
        case 0:{
            areaType = 1;
            CarNumberModel *model = self.provenceArr[indexPath.row];
            [self.shengBtn setTitle:model.areaName forState:UIControlStateNormal];
            [self.shengBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
            [self.shiBtn setTitle:@"请选择" forState:UIControlStateNormal];
            [self.shiBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
            self.shiBtn.hidden = NO;
            shengStr = model.areaName;
            [DataGreatWall PostTheAddressWithTheCompanyCode:self.insureId WithTheAreaCode:model.areaCode WithBlock:^(NSString *respCode, NSString *respMsg, NSString *pageSize, NSString *totalCount, NSMutableArray *array, NSError *error) {
                if (error) {
                }else if ([respCode isEqualToString:@"000000"]){
                    self.cityArr = [[NSMutableArray alloc]initWithArray:array];
                    [self.tabView reloadData];
                }else{
                    
                }
            }];
        }
            break;
        case 1:{
            areaType = 2;
            CarNumberModel *model = self.cityArr[indexPath.row];
            [self.shiBtn setTitle:model.areaName forState:UIControlStateNormal];
            [self.shiBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
            self.block(shengStr,model.areaName,nil,model.licensePreff);
            [self cancelClick];
        }
            break;
        default:
            break;
    }
    [tableView reloadData];
    [UIView animateWithDuration:0.2 animations:^{
        if (areaType == 0) {
            underLine.frame = CGRectMake(self.shengBtn.frame.origin.x, rect.origin.y, self.shengBtn.frame.size.width,  rect.size.height);
        }else if (areaType == 1){
            underLine.frame = CGRectMake(self.shiBtn.frame.origin.x, rect.origin.y, self.shiBtn.frame.size.width,  rect.size.height);
        }
    }];
    
    tableView.contentOffset = CGPointMake(0, 0);
}

- (void)btnAction:(UIButton *)sender{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case 1000:
            areaType = 0;
            break;
        case 1001:
            areaType = 1;
            break;
        default:
            break;
    }
    [self.tabView reloadData];
    [sender layoutIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = underLine.frame;
        underLine.frame = CGRectMake(sender.frame.origin.x, rect.origin.y, sender.frame.size.width, rect.size.height);
    }];
}









-(void)backAction:(UIButton *)sender{
    [self cancelClick];
}
- (void)LYShareTypeBackSelectBlock:(AddressSelectBlock)block{
    self.block = block;
}
-(void)cancelClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.background.y = [UIScreen mainScreen].bounds.size.height;
    }completion:^(BOOL finished) {
        [self.background removeFromSuperview];
        self.background = nil;
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
}


@end
