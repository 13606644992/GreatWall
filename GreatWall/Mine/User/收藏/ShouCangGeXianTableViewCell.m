//
//  GeXianTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/3/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ShouCangGeXianTableViewCell.h"
#import "OnlyLine.h"
#import "ShouCangModel.h"

@implementation ShouCangGeXianTableViewCell

+(instancetype)MallcellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MallCell";
    ShouCangGeXianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor whiteColor];
        [cell initMallCellAnyThingWith];
    }
    return cell;
}
-(void)initMallCellAnyThingWith
{
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(13*HEIGHT);
        make.top.equalTo(self.contentView).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(120*WEIGHT, 90*HEIGHT));
    }];
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleImg.mas_right).with.offset(16*WEIGHT);
        make.top.equalTo(self.titleImg);
        make.size.mas_equalTo(CGSizeMake(150, 16*HEIGHT));
    }];
    [self.contentView addSubview:self.hotLab];
    [self.hotLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).with.offset(6*WEIGHT);
        make.top.equalTo(self.titleLab);
        make.size.mas_equalTo(CGSizeMake(29*WEIGHT, 14*HEIGHT));
    }];
    
    [self.contentView addSubview:self.actionLab];
    [self.actionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hotLab.mas_right).with.offset(6*WEIGHT);
        make.top.equalTo(self.titleLab);
        make.size.mas_equalTo(CGSizeMake(29*WEIGHT, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.ageLab];
    [self.ageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(11*HEIGHT);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-20*HEIGHT);
        make.height.equalTo(@(11*HEIGHT));
    }];
    [self.contentView addSubview:self.secLab];
    [self.secLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.ageLab.mas_top).with.offset(18*HEIGHT);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-20*HEIGHT);
        make.height.equalTo(@(11*HEIGHT));
    }];
    [self.contentView addSubview:self.thirdLab];
    [self.thirdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.secLab.mas_top).with.offset(18*HEIGHT);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-20*HEIGHT);
        make.height.equalTo(@(11*HEIGHT));
    }];
    [self.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleImg.mas_right).with.offset(30*WIDTH);
        make.top.mas_equalTo(self.thirdLab.mas_bottom).with.offset(14*HEIGHT);
        make.width.equalTo(@(100));
        make.height.equalTo(@(17*WIDTH));
    }];
    [self.contentView addSubview:self.rmbLab];
    [self.rmbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.bottom.equalTo(self.amountLab);
        make.size.mas_equalTo(CGSizeMake(14*WEIGHT, 14*HEIGHT));
    }];
    
    //    金额种类
    
    [self.contentView addSubview:self.qiLab];
    [self.qiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right);
        make.bottom.equalTo(self.amountLab);
        make.width.equalTo(@(14*WEIGHT));
        make.height.equalTo(@(14*HEIGHT));
    }];
    
    [self.contentView addSubview:self.brandLab];
    [self.brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleImg).with.offset(-9*HEIGHT);
        make.centerX.equalTo(self.titleImg);
        make.size.mas_equalTo(CGSizeMake(85*WIDTH, 18*HEIGHT));
    }];
    //    返现背景图
    [self.contentView addSubview:self.fanImg];
    [self.fanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-13*WEIGHT);
        make.bottom.mas_equalTo(self.amountLab.mas_bottom).with.offset(0);
        make.height.equalTo(@(16*HEIGHT));
        make.width.equalTo(@(96*WEIGHT));
    }];
    //    返现金额比例
    [self.contentView addSubview:self.fanLab];
    [self.fanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.fanImg);
        make.size.mas_equalTo(CGSizeMake(80*WEIGHT, 11*HEIGHT));
    }];
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.fanImg);
        make.bottom.equalTo(self.amountLab);
        make.height.equalTo(@(12*HEIGHT));
    }];
    
}
-(void)setModel:(ShouCangModel *)model
{
    NSLog(@"--IS_Bclient**************************-%@",IS_Bclient);
    if ([IS_Bclient integerValue] == 1) {
        self.fanImg.hidden = NO;
        self.fanLab.hidden = NO;
        self.countLab.hidden = YES;
    }else{
        self.fanImg.hidden = YES;
        self.fanLab.hidden = YES;
        self.countLab.hidden = NO;
    }
//    self.titleLab.text = model.productName;
//    CGRect tempRectHot = [model.productName  boundingRectWithSize:CGSizeMake(101.5*WIDTH,16*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16*WEIGHT]}context:nil];
//    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(tempRectHot.size.width+1));
//    }];
//    [self.titleImg sd_setImageWithURL:[NSURL URLWithString:model.productLogo] placeholderImage:PlaceImage];
//    self.ageLab.text = [NSString stringWithFormat:@"投保年龄： %@",model.ageDesc];
//    
//    self.brandLab.text = model.insurerName;
//    self.countLab.text = [NSString stringWithFormat:@"销量 %@份",model.totalAmount];
//    self.amountLab.text = [NSString stringWithFormat:@"%.02f",[model.productPrice floatValue]/100];
//    CGRect tempRect = [self.amountLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-220,17*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17*WEIGHT]}context:nil];
//    [self.amountLab mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(tempRect.size.width+5));
//    }];
//    self.fanLab.text = [NSString stringWithFormat:@"推广费最高%@%@",model.commisionValue1,@"%"];
//    [self layoutIfNeeded];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ----------Controller---------
-(UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:PlaceImage];
    }
    return _titleImg;
}
-(UILabel *)hotLab
{
    if (!_hotLab) {
        _hotLab = [[UILabel alloc] init];
        _hotLab.backgroundColor = UIColorRGBA(255, 83, 70, 1);
        _hotLab.layer.cornerRadius = 2*WIDTH;
        _hotLab.text = @"爆款";
        _hotLab.textAlignment = NSTextAlignmentCenter;
        _hotLab.textColor = [UIColor whiteColor];
        _hotLab.font = [UIFont systemFontOfSize:11*WIDTH];
        _hotLab.clipsToBounds = YES;
    }
    return _hotLab;
}
-(UILabel *)actionLab
{
    if (!_actionLab) {
        _actionLab = [[UILabel alloc] init];
        _actionLab.backgroundColor = UIColorRGBA(255, 83, 70, 1);
        _actionLab.layer.cornerRadius = 2*WIDTH;
        _actionLab.clipsToBounds = YES;
        _actionLab.text = @"新品";
        _actionLab.textAlignment = NSTextAlignmentCenter;
        _actionLab.textColor = [UIColor whiteColor];
        _actionLab.font = [UIFont systemFontOfSize:11*WIDTH];
    }
    return _actionLab;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        //        _titleLab.backgroundColor = [UIColor redColor];
        _titleLab.font = [UIFont systemFontOfSize:16*WEIGHT];
        _titleLab.text = @"守护定期寿险";
    }
    return _titleLab;
}
-(UILabel *)brandLab
{
    if (!_brandLab) {
        _brandLab = [[UILabel alloc] init];
        _brandLab.textColor = LYColor_A3;
        _brandLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _brandLab.textAlignment = NSTextAlignmentCenter;
        _brandLab.backgroundColor = [UIColor whiteColor];
        _brandLab.text = @"太平洋保险";
        _brandLab.layer.cornerRadius = 9.0f*HEIGHT;
        _brandLab.alpha = 0.8;
        _brandLab.clipsToBounds = YES;
    }
    return _brandLab;
}
-(UILabel *)ageLab
{
    if (!_ageLab) {
        _ageLab = [[UILabel alloc] init];
        _ageLab.textColor = LYColor_A4;
        _ageLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _ageLab.text = @"投保年龄：18-45周岁";
    }
    return _ageLab;
}
-(UILabel *)secLab
{
    if (!_secLab) {
        _secLab = [[UILabel alloc] init];
        _secLab.textColor = LYColor_A4;
        _secLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _secLab.text = @"疾病身故或全残：30万元";
    }
    return _secLab;
}
-(UILabel *)thirdLab
{
    if (!_thirdLab) {
        _thirdLab = [[UILabel alloc] init];
        _thirdLab.textColor = LYColor_A4;
        _thirdLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _thirdLab.text = @"意外身故或全残：30万元";
    }
    return _thirdLab;
}
-(UILabel *)rmbLab
{
    if (!_rmbLab) {
        _rmbLab = [[UILabel alloc] init];
        _rmbLab.text = @"¥";
        _rmbLab.textColor = LYColor_A1;
        _rmbLab.font = [UIFont systemFontOfSize:14*WEIGHT];
    }
    return _rmbLab;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] init];
        _amountLab.textColor = LYColor_A1;
        _amountLab.font = [UIFont systemFontOfSize:17*WEIGHT];
        _amountLab.text = @"1000";
    }
    return _amountLab;
}
-(UILabel *)qiLab
{
    if (!_qiLab) {
        _qiLab = [[UILabel alloc] init];
        _qiLab.textColor = LYColor_A4;
        _qiLab.font = [UIFont systemFontOfSize:14*WEIGHT];
        _qiLab.text = @"起";
    }
    return _qiLab;
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
        _fanLab.text = @"推广费最高20%";
    }
    return _fanLab;
}
-(UILabel *)countLab
{
    if (!_countLab) {
        _countLab = [[UILabel alloc] init];
        _countLab.textColor = LYColor_A4;
        _countLab.font = [UIFont systemFontOfSize:12*WIDTH];
        _countLab.text = @"销量 12万份";
        _countLab.textAlignment = NSTextAlignmentRight;
    }
    return _countLab;
}
-(AllLine *)lineView
{
    if (!_lineView) {
        _lineView = [[AllLine alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 147*HEIGHT)];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
