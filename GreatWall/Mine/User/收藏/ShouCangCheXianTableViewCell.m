//
//  CheXianTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/3/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ShouCangCheXianTableViewCell.h"
#import "ShouCangModel.h"

@implementation ShouCangCheXianTableViewCell

+(instancetype)MallcellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CarMallCell";
    ShouCangCheXianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor whiteColor];
        [cell initMallCellAnyThingWith];
    }
    return cell;
}
-(void)initMallCellAnyThingWith
{
    //    底部虚线
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
        make.right.equalTo(self.contentView).with.offset(-13*WEIGHT);
        make.top.equalTo(self.contentView).with.offset(21*HEIGHT);
        make.height.equalTo(@(16*HEIGHT));
    }];
    [self.contentView addSubview:self.carTypeLab];
    [self.carTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(11*HEIGHT);
        make.right.equalTo(self.titleLab);
        make.height.equalTo(@(11*HEIGHT));
    }];
    [self.contentView addSubview:self.areaLab];
    [self.areaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.carTypeLab.mas_bottom).with.offset(7*HEIGHT);
        make.right.equalTo(self.titleLab);
        make.height.equalTo(@(11*HEIGHT));
    }];
    
    [self.contentView addSubview:self.brandLab];
    [self.brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleImg).with.offset(-9*HEIGHT);
        make.centerX.equalTo(self.titleImg);
        make.size.mas_equalTo(CGSizeMake(85*WIDTH, 18*HEIGHT));
    }];
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.areaLab.mas_bottom).with.offset(14*HEIGHT);
        make.left.mas_equalTo(self.titleLab);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-13*WEIGHT);
        make.height.equalTo(@(12*HEIGHT));
    }];
    //    返现背景图
    [self.contentView addSubview:self.fanImg];
    [self.fanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.areaLab.mas_bottom).with.offset(14*HEIGHT);
        make.left.mas_equalTo(self.titleLab);
        make.height.equalTo(@(16*HEIGHT));
        make.width.equalTo(@(96*WEIGHT));
    }];
    //    返现金额比例
    [self.contentView addSubview:self.fanLab];
    [self.fanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.fanImg);
        make.size.mas_equalTo(CGSizeMake(80*WEIGHT, 11*HEIGHT));
    }];
}
-(void)setModel:(ShouCangModel *)model
{
    
    if ([IS_Bclient integerValue] == 1) {
        self.fanLab.hidden = NO;
        self.fanImg.hidden = NO;
        self.countLab.hidden = YES;
    }else{
        self.fanLab.hidden = YES;
        self.fanImg.hidden = YES;
        self.countLab.hidden = NO;
    }
//    self.titleLab.text = model.productName;
//    [self.titleImg sd_setImageWithURL:[NSURL URLWithString:model.productLogo] placeholderImage:PlaceImage];
//    self.brandLab.text = model.insurerName;
//    self.countLab.text = [NSString stringWithFormat:@"销量 %@份",model.totalAmount];
}
#pragma mark  -----Controller-------------
-(UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:PlaceImage];
    }
    return _titleImg;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        _titleLab.font = [UIFont systemFontOfSize:16*WEIGHT];
        _titleLab.text = @"平安车险";
    }
    return _titleLab;
}
-(UILabel *)carTypeLab
{
    if (!_carTypeLab) {
        _carTypeLab = [[UILabel alloc] init];
        _carTypeLab.textColor = LYColor_A4;
        _carTypeLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _carTypeLab.text = @"承包车辆：9座以下非营运客车";
    }
    return _carTypeLab;
}
-(UILabel *)areaLab
{
    if (!_areaLab) {
        _areaLab = [[UILabel alloc] init];
        _areaLab.textColor = LYColor_A4;
        _areaLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _areaLab.text = @"承保地区：全国";
    }
    return _areaLab;
}
-(UILabel *)brandLab
{
    if (!_brandLab) {
        _brandLab = [[UILabel alloc] init];
        _brandLab.textColor = LYColor_A3;
        _brandLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _brandLab.textAlignment = NSTextAlignmentCenter;
        _brandLab.backgroundColor = [UIColor whiteColor];
        _brandLab.text = @"中国平安";
        _brandLab.layer.cornerRadius = 9.0f*HEIGHT;
        _brandLab.alpha = 0.8;
        _brandLab.clipsToBounds = YES;
    }
    return _brandLab;
}
-(UILabel *)countLab
{
    if (!_countLab) {
        _countLab = [[UILabel alloc] init];
        _countLab.textColor = LYColor_A1;
        _countLab.font = [UIFont systemFontOfSize:12*WEIGHT];
        _countLab.text = @"销量 12万份";
        //        _countLab.textAlignment = NSTextAlignmentRight;
    }
    return _countLab;
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
        _fanLab.text = @"推广费最高25%";
    }
    return _fanLab;
}
-(AllLine *)lineView
{
    if (!_lineView) {
        _lineView = [[AllLine alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 132*HEIGHT)];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
