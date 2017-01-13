//
//  DescriptionController.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DescriptionController.h"
#import "Header.h"
#import "DescriptionCell.h"
#import "DescriptionTypeTwoCell.h"
#import "DescriptionTypeSexCell.h"
#import "DescriptionDateCell.h"
#import "DescriptionImageCell.h"

@interface DescriptionController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isOpen[10];
    NSArray *titleArray;
    NSString *selectSex;
    NSString *SelectDate;
}
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)UIButton *backButton;
@property(nonatomic ,strong)UIButton *collectButton;
@property(nonatomic ,strong)UIView *footView;
@property(nonatomic ,strong)UIView *grayView;
@property(nonatomic ,strong)UIView *bottomView;
@property(nonatomic ,strong)UILabel *amountLab;
@property(nonatomic ,strong)UIButton *shareButton;
@property(nonatomic ,strong)UIImageView *shareImg;
@property(nonatomic ,strong)UILabel *shareLab;
@property(nonatomic ,strong)UILabel *lineLab;
@property(nonatomic ,strong)UIButton *insureBtn;
@property(nonatomic ,strong)UILabel *typeLab;
@property(nonatomic ,strong)UILabel *titleLab;
@property (nonatomic, strong) UIImageView *fanImg;
@property (nonatomic, strong) UILabel *fanLab;
@property (nonatomic, strong) NSArray *fourArray;



@end

@implementation DescriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = LYColor_A7;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(26);
        make.left.equalTo(self.view).with.offset(18*WEIGHT);
        make.size.mas_equalTo(CGSizeMake(32*WEIGHT, 32*WEIGHT));
    }];
    [self.view addSubview:self.collectButton];
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(26);
        make.right.equalTo(self.view).with.offset(-18*WEIGHT);
        make.size.mas_equalTo(CGSizeMake(32*WEIGHT, 32*WEIGHT));
    }];
    [self setTheFootView];
    titleArray = @[@"投保年龄",@"保障时间",@"职业类别",@"被保人性别",@"出生日期"];
    selectSex = @"女";
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    StatusBarBlack;
}

//底部View
-(void)setTheFootView
{
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(59));
    }];
    [self.footView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.footView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.footView);
        make.width.equalTo(@(110*WIDTH));
    }];
    [self.footView addSubview:self.lineLab];
    [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right);
        make.top.bottom.equalTo(self.footView);
        make.width.equalTo(@(0.5));
    }];
    [self.footView addSubview:self.insureBtn];
    [self.insureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.footView);
        make.width.equalTo(@(114.5*WIDTH));
    }];
    [self.footView addSubview:self.shareImg];
    [self.shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right).with.offset(40*WIDTH);
        make.centerY.equalTo(self.footView);
        make.size.mas_equalTo(CGSizeMake(18*WIDTH, 18*WIDTH));
    }];
    [self.footView addSubview:self.shareLab];
    [self.shareLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shareImg.mas_right).with.offset(6*WIDTH);
        make.centerY.equalTo(self.footView);
        make.size.mas_equalTo(CGSizeMake(40*WIDTH, 18*WIDTH));
    }];
    [self.footView addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right).with.offset(1*WIDTH);
        make.right.mas_equalTo(self.insureBtn.mas_left);
        make.centerY.equalTo(self.footView);
        make.height.equalTo(@(59));
    }];
    

}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)collectBtnClick
{
    NSLog(@"收藏");
}
-(void)shareClick:(UIButton *)sender
{
    NSLog(@"share-------");
}
-(void)toInsureClick:(UIButton *)sender
{
    NSLog(@"我要投保-------");
}
#pragma mark  -----------Controller--------
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 342*HEIGHT;
    }else if (section ==1){
        return 107*HEIGHT;
    }else if (section == 2){
        return 39*HEIGHT;
    }
    return 74*HEIGHT;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [self setTheFirstHeaderView];
    }else if (section == 1){
        return [self setTheSecondHeaderView];
    }else if (section == 2){
        return [self setTheThirdHeaderView];
    }
    return [self setTheFourthHeaderView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }else if (section == 2){
        return 1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 49*HEIGHT;
        }
        if (!isOpen[indexPath.row+1]) {
            return 49*HEIGHT;
        }else{
            return 75*HEIGHT;
        }

    }
//    if (indexPath.section == 2) {
        return 119*HEIGHT;
//    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0||indexPath.row == 2) {
            DescriptionCell *cell = [DescriptionCell cellWithTableView:tableView];
            cell.titleLab.text = titleArray[indexPath.row];
            return cell;
        }else if (indexPath.row == 1){
            DescriptionTypeTwoCell *cell = [DescriptionTypeTwoCell cellWithTableView:tableView];
            [cell.detailButton  addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.detailButton.tag = indexPath.row+1;
            cell.titleLab.text = titleArray[indexPath.row];
            cell.tag = indexPath.row+100;
            return cell;
        }else if (indexPath.row == 3){
            DescriptionTypeSexCell *cell = [DescriptionTypeSexCell cellWithTableView:tableView];
            [cell.detailButton  addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.detailButton.tag = indexPath.row+1;
            cell.titleLab.text = titleArray[indexPath.row];
            cell.tag = indexPath.row+100;
            [cell.mainBtn addTarget:self action:@selector(sexSelectMain:) forControlEvents:UIControlEventTouchUpInside];
            cell.mainBtn.tag = indexPath.row+200;
            [cell.womanBtn addTarget:self action:@selector(sexSelectWoman:) forControlEvents:UIControlEventTouchUpInside];
            cell.womanBtn.tag = indexPath.row+201;
            cell.detialLab.text = selectSex;
            if (!isOpen[indexPath.row+1]) {
                cell.womanBtn.hidden = YES;cell.mainBtn.hidden = YES;}else{cell.womanBtn.hidden = NO;cell.mainBtn.hidden = NO;
                }
            return cell;
        }
        DescriptionDateCell *cell = [DescriptionDateCell cellWithTableView:tableView];
        [cell.detailButton  addTarget:self action:@selector(dataPickSelectTime:) forControlEvents:UIControlEventTouchUpInside];
        cell.detailButton.tag = indexPath.row+300;
        cell.titleLab.text = titleArray[indexPath.row];
        cell.tag = indexPath.row+100;
        return cell;
    }
    DescriptionImageCell *cell = [DescriptionImageCell cellWithTableView:tableView];
    
    return cell;

}
-(void)dataPickSelectTime:(UIButton *)sender
{
    [self.view addSubview:self.bottomView];
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = self.bottomView.frame;
        rect.origin.y = ScreenWindowHeight-240*HEIGHT;
        self.bottomView.frame = rect;
    } completion:^(BOOL finished) {
        [self.view addSubview:self.grayView];
        [self.view bringSubviewToFront:self.bottomView];
    }];
}
-(void)cancelClick
{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = self.bottomView.frame;
        rect.origin.y = ScreenWindowHeight;
        self.bottomView.frame = rect;
    } completion:^(BOOL finished) {
        [self.bottomView removeFromSuperview];
        [self.grayView removeFromSuperview];
    }];

}
-(void)sureClick
{
    NSLog(@"queren-----------");
}

#pragma mark  ----------TheFirstHeader--------

//第一区（标题图片，返回，收藏）
-(UIView *)setTheFirstHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth,  342*HEIGHT)];
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:PlaceImage];
    [headerView addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(headerView);
        make.height.equalTo(@(281*HEIGHT));
    }];
    [headerView addSubview:self.typeLab];
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).with.offset(-18*WIDTH);
        make.bottom.equalTo(bgImg).with.offset(-20*HEIGHT);
        make.left.equalTo(headerView).with.offset(100*WIDTH);
        make.height.equalTo(@(14*HEIGHT));
    }];
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgImg);
        make.top.mas_equalTo(bgImg.mas_bottom);
        make.height.equalTo(@(61*HEIGHT));
    }];
    [headerView addSubview:self.fanImg];
    [self.fanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView).with.offset(-13*WEIGHT);
        make.centerY.equalTo(whiteView);
        make.height.equalTo(@(16.5*HEIGHT));
        make.width.equalTo(@(80*WEIGHT));
    }];
    //    返现金额比例
    [headerView addSubview:self.fanLab];
    [self.fanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.fanImg);
        make.size.mas_equalTo(CGSizeMake(60*WEIGHT, 11*HEIGHT));
    }];

    [headerView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView).with.offset(18*WEIGHT);
        make.right.mas_equalTo(self.fanImg.mas_left).with.offset(-30*WIDTH);
        make.centerY.equalTo(whiteView);
        make.height.equalTo(@(17*HEIGHT));
    }];

    
    return headerView;
}
#pragma mark  --------TheSecondHeader--------------------

//第二区（动态cell，内容选择）
-(UIView *)setTheSecondHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth,  87.5*HEIGHT)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *firstContentLab = [[UILabel alloc] init];
    firstContentLab.textColor = LYColor_A4;
    firstContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
    firstContentLab.text = @"人身意外伤害-身故、残疾";
    [headerView addSubview:firstContentLab];
    [firstContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(13*WIDTH);
        make.top.equalTo(headerView).with.offset(21*HEIGHT);
        make.right.equalTo(headerView).with.offset(-93*WIDTH);
        make.height.equalTo(@(13*WIDTH));
    }];
    UILabel *secondContentLab = [[UILabel alloc] init];
    secondContentLab.textColor = LYColor_A4;
    secondContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
    secondContentLab.text = @"意外医疗费用（免赔额100元，90%赔付）";
    [headerView addSubview:secondContentLab];
    [secondContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(13*WIDTH);
        make.top.mas_equalTo(firstContentLab.mas_bottom).with.offset(13*HEIGHT);
        make.right.equalTo(headerView).with.offset(-93*WIDTH);
        make.height.equalTo(@(13*WIDTH));
    }];

    UILabel *thirdContentLab = [[UILabel alloc] init];
    thirdContentLab.textColor = LYColor_A4;
    thirdContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
    thirdContentLab.text = @"银行卡盗刷";
    [headerView addSubview:thirdContentLab];
    [thirdContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(13*WIDTH);
        make.top.mas_equalTo(secondContentLab.mas_bottom).with.offset(13*HEIGHT);
        make.right.equalTo(headerView).with.offset(-93*WIDTH);
        make.height.equalTo(@(13*WIDTH));
    }];
    
    UILabel *firstDetailContentLab = [[UILabel alloc] init];
    firstDetailContentLab.textColor = LYColor_A3;
    firstDetailContentLab.textAlignment = NSTextAlignmentRight;
    firstDetailContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
    firstDetailContentLab.text = @"10万";
    [headerView addSubview:firstDetailContentLab];
    [firstDetailContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).with.offset(21*HEIGHT);
        make.right.equalTo(headerView).with.offset(-13*WIDTH);
        make.height.equalTo(@(13*HEIGHT));
        make.width.equalTo(@(80*WIDTH));
    }];
    UILabel *secondDetailContentLab = [[UILabel alloc] init];
    secondDetailContentLab.textColor = LYColor_A3;
    secondDetailContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
    secondDetailContentLab.text = @"5000万";
    secondDetailContentLab.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:secondDetailContentLab];
    [secondDetailContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).with.offset(-13*WIDTH);
        make.top.mas_equalTo(firstDetailContentLab.mas_bottom).with.offset(13*HEIGHT);
        make.height.equalTo(@(13*WIDTH));
        make.width.equalTo(@(80*WIDTH));

    }];
    
    UILabel *thirdDetailContentLab = [[UILabel alloc] init];
    thirdDetailContentLab.textColor = LYColor_A3;
    thirdDetailContentLab.font = [UIFont systemFontOfSize:13*WIDTH];
    thirdDetailContentLab.text = @"1万";
    thirdDetailContentLab.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:thirdDetailContentLab];
    [thirdDetailContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(secondDetailContentLab.mas_bottom).with.offset(13*HEIGHT);
        make.right.equalTo(headerView).with.offset(-13*WIDTH);
        make.height.equalTo(@(13*WIDTH));
        make.width.equalTo(@(80*WIDTH));
    }];
    
    return headerView;
}
-(void)sexSelectMain:(UIButton *)sender
{
    isOpen[sender.tag-199] = !isOpen[sender.tag-199];
    
    DescriptionTypeSexCell *cell = (DescriptionTypeSexCell *)[self.tableView viewWithTag:sender.tag-100];
    cell.detialLab.text = @"男";
    selectSex = @"男";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
-(void)sexSelectWoman:(UIButton *)sender
{
    isOpen[sender.tag-200] = !isOpen[sender.tag-200];
    DescriptionTypeSexCell *cell = (DescriptionTypeSexCell *)[self.tableView viewWithTag:sender.tag-101];
    cell.detialLab.text = @"女";
    selectSex = @"女";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
-(void)searchClick:(UIButton *)sender
{
    isOpen[sender.tag] = !isOpen[sender.tag];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
    });
}
- (NSString *)dateToStringWithDate:(NSDate *)selectDate {
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间的格式
    NSString * dateAndTime = [selectDateFormatter stringFromDate:selectDate]; // 把date类型转为设置好格式的string类型
    return dateAndTime;
}
- (void)datePickerValueChanged:(UIDatePicker *)datepiker {
    SelectDate = [self dateToStringWithDate:[datepiker date]];
}
#pragma mark  --------TheThirdHeader--------------------
-(UIView *)setTheThirdHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth,  39*HEIGHT)];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"产品详情";
    titleLab.textColor = LYColor_A4;
    titleLab.font = [UIFont systemFontOfSize:13*WIDTH];
    [headerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(18*WIDTH);
        make.centerY.equalTo(headerView);
        make.height.equalTo(@(13*HEIGHT));
    }];
    return headerView;
}
#pragma mark  --------TheThirdHeader--------------------

-(UIView *)setTheFourthHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth,  75*HEIGHT)];
    
    CGFloat kuan = ScreenWindowWidth/4;
    CGFloat gao = 74*HEIGHT;
    for (NSInteger i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*kuan, 0, kuan, gao);
        button.tag = 50+i;
        [button setTitle:self.fourArray[i] forState:UIControlStateNormal];
        [button setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12*WIDTH];
        [button addTarget:self action:@selector(tiaoKuanClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
        if (i!=3) {
            UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake((i+1)*kuan, 32*HEIGHT, 0.5, 12*HEIGHT)];
            lineLab.backgroundColor = LYColor_A6;
            [headerView addSubview:lineLab];
        }
    }
    return headerView;
}

-(void)tiaoKuanClick:(UIButton *)sender
{
    NSLog(@"-----%ld",sender.tag);
}
#pragma mark  -----------Controller--------

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -59, ScreenWindowWidth, ScreenWindowHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorColor = LYColor_A7;
    }
    return _tableView;
}
-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"fanhui(chanpingxinagqingye)"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _backButton;
}
-(UIButton *)collectButton
{
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [_collectButton addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}
-(UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] init];
        _amountLab.textColor = LYColor_A2;
        _amountLab.font = [UIFont systemFontOfSize:21*WIDTH];
        _amountLab.textAlignment = NSTextAlignmentCenter;
        _amountLab.text = @"¥ 116.00";
    }
    return _amountLab;
}
-(UIImageView *)shareImg
{
    if (!_shareImg) {
        _shareImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenxiang"]];
    }
    return _shareImg;
}
-(UILabel *)shareLab
{
    if (!_shareLab) {
        _shareLab = [[UILabel alloc] init];
        _shareLab.textColor = LYColor_A1;
        _shareLab.text = @"分享";
        _shareLab.font = [UIFont systemFontOfSize:18*WIDTH];
    }
    return _shareLab;
}
-(UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}
-(UIButton *)insureBtn
{
    if (!_insureBtn) {
        _insureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_insureBtn addTarget:self action:@selector(toInsureClick:) forControlEvents:UIControlEventTouchUpInside];
        [_insureBtn setTitle:@"我要投保" forState:UIControlStateNormal];
        _insureBtn.backgroundColor = LYColor_A1;
        [_insureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _insureBtn;
}
-(UILabel *)lineLab
{
    if (!_lineLab) {
        _lineLab = [[UILabel alloc] init];
        _lineLab.backgroundColor = LYColor_A7;
    }
    return _lineLab;
}
-(UILabel *)typeLab
{
    if (!_typeLab) {
        _typeLab = [[UILabel alloc] init];
        _typeLab.textColor = [UIColor whiteColor];
        _typeLab.text = @"大西洋保险 | 销量133759";
        _typeLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _typeLab.textAlignment = NSTextAlignmentRight;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:_typeLab.text];
        NSShadow *shadow = [[NSShadow alloc]init];
        _typeLab.shadowColor = [UIColor colorWithWhite:0.1f alpha:0.39f];
        shadow.shadowOffset = CGSizeMake(0, 0);
        shadow.shadowBlurRadius = 4;
        [AttributedStr addAttribute:NSShadowAttributeName
         
                              value:shadow
         
                              range:NSMakeRange(0, _typeLab.text.length)];
        _typeLab.attributedText = AttributedStr;
        
    }
    return _typeLab;
}
-(UIImageView *)fanImg
{
    if (!_fanImg) {
        _fanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tuiguangfeibiaoqian"]];
    }
    return _fanImg;
}
-(UILabel *)fanLab
{
    if (!_fanLab) {
        _fanLab =[[UILabel alloc] init];
        _fanLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _fanLab.textColor = [LYColor colorWithHexString:@"ffffff"];
        _fanLab.textAlignment = NSTextAlignmentCenter;
        _fanLab.text = @"16%推广费";
    }
    return _fanLab;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab =[[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:19*WEIGHT];
        _titleLab.textColor = LYColor_A3;
        _titleLab.text = @"成人综合意外险";
    }
    return _titleLab;
}
-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWindowHeight, ScreenWindowWidth, 240*HEIGHT)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
        [_bottomView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_bottomView);
            make.size.mas_equalTo(CGSizeMake(80*WIDTH, 40*HEIGHT));
        }];
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH];
        [sureBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(_bottomView);
            make.size.mas_equalTo(CGSizeMake(80*WIDTH, 40*HEIGHT));
        }];
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        [datePicker setTimeZone:[NSTimeZone localTimeZone]];
        [datePicker setDate:[NSDate date] animated:YES];
        datePicker.backgroundColor = [UIColor whiteColor];
        UIDatePickerMode  pikcerMode = UIDatePickerModeDate;
        NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSince1970:20*365*24*60*60];
        datePicker.minimumDate = maxDate;
        NSDate *minDate = [NSDate date];
        datePicker.maximumDate = minDate;
        [datePicker setDatePickerMode:pikcerMode];
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_bottomView addSubview:datePicker];
        SelectDate = [self dateToStringWithDate:[NSDate date]];
        [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cancelBtn);
            make.top.mas_equalTo(cancelBtn.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth, 200*HEIGHT));
        }];
    }
    return _bottomView;
}

-(UIView *)grayView
{
    if (!_grayView) {
        _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight)];
        _grayView.backgroundColor = [UIColor lightGrayColor];
        _grayView.alpha = 0.4;
    }
    return _grayView;
}
-(NSArray *)fourArray
{
    if (!_fourArray) {
        _fourArray = @[@"投保须知",@"理赔流程",@"常见问题",@"案例分析"];
    }
    return _fourArray;
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
