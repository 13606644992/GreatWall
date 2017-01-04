//
//  MallCell.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/26.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "MallCell.h"
#import "OnlyLine.h"

@implementation MallCell
+(instancetype)MallcellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MallCell";
    MallCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor whiteColor];
        [cell initMallCellAnyThingWith];
    }
    return cell;
}
-(void)initMallCellAnyThingWith
{
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
    [self.contentView addSubview:self.hotImage];
    [self.hotImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).with.offset(10*WEIGHT);
        make.top.equalTo(self.titleLab);
        make.size.mas_equalTo(CGSizeMake(16*WEIGHT, 16*HEIGHT));
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
        make.top.mas_equalTo(self.ageLab.mas_top).with.offset(18);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-20*HEIGHT);
        make.height.equalTo(@(11*HEIGHT));
    }];
    [self.contentView addSubview:self.thirdLab];
    [self.thirdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.secLab.mas_top).with.offset(18);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-20*HEIGHT);
        make.height.equalTo(@(11*HEIGHT));
    }];
    [self.contentView addSubview:self.rmbLab];
    [self.rmbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.thirdLab.mas_bottom).with.offset(15*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(14*WEIGHT, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rmbLab.mas_right);
        make.bottom.mas_equalTo(self.rmbLab.mas_bottom).with.offset(0*HEIGHT);
        make.width.equalTo(@(100));
        make.height.equalTo(@(17*HEIGHT));
    }];
    //    金额种类

    [self.contentView addSubview:self.qiLab];
    [self.qiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right).with.offset(0);
        make.bottom.mas_equalTo(self.amountLab.mas_bottom).with.offset(0);
        make.width.equalTo(@(14*WEIGHT));
        make.height.equalTo(@(14*HEIGHT));
    }];

    OnlyLine *line = [[OnlyLine alloc] initWithFrame:CGRectMake(129*WEIGHT, 138*HEIGHT, 246*WEIGHT, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:line];
    [self.contentView addSubview:self.borderView];
    [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.amountLab.mas_bottom).with.offset(28*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(60*HEIGHT, 24*HEIGHT));
    }];
    [self.contentView addSubview:self.brandLab];
    [self.brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.borderView);
        make.size.mas_equalTo(CGSizeMake(56*HEIGHT, 16*HEIGHT));
    }];
    //    返现背景图
    [self.contentView addSubview:self.fanImg];
    [self.fanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-13*WEIGHT);
        make.bottom.mas_equalTo(self.amountLab.mas_bottom).with.offset(0);
        make.height.equalTo(@(17*HEIGHT));
        make.width.equalTo(@(80*WEIGHT));
    }];
    //    返现金额比例
    [self.contentView addSubview:self.fanLab];
    [self.fanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.fanImg);
        make.size.mas_equalTo(CGSizeMake(60*WEIGHT, 11*HEIGHT));
    }];
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-13*WEIGHT);
        make.centerY.mas_equalTo(self.borderView.mas_centerY);
        make.height.equalTo(@(12*HEIGHT));
    }];

}
-(void)setModel:(MallModel *)model
{
    CGRect tempRectHot = [self.titleLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-220,16*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16*WEIGHT]}context:nil];
    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tempRectHot.size.width+1));
    }];
    CGRect tempRect = [self.amountLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-220,17*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17*WEIGHT]}context:nil];
    [self.amountLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tempRect.size.width+5));
    }];
    CGRect tempRectBrand = [self.brandLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-220,11*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11*WEIGHT]}context:nil];
    [self.borderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(tempRectBrand.size.width+28*WEIGHT, 24*HEIGHT));
    }];
    [self.brandLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(tempRectBrand.size.width+22*WEIGHT, 18*HEIGHT));
    }];
    [self layoutIfNeeded];

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
-(UIImageView *)hotImage
{
    if (!_hotImage) {
        _hotImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hot"]];
    }
    return _hotImage;
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
        _brandLab.textColor = [LYColor colorWithHexString:@"#ffae22"];
        _brandLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _brandLab.textAlignment = NSTextAlignmentCenter;
        _brandLab.backgroundColor = UIColorRGBA(255, 240, 214, 1);
        _brandLab.text = @"新华保险";
        _brandLab.layer.cornerRadius = 2.0f;
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
-(UIView *)borderView
{
    if (!_borderView) {
        _borderView = [[UIView alloc] init];
        _borderView.backgroundColor = [UIColor clearColor];
        _borderView.layer.borderWidth = 1.0f;
        _borderView.layer.borderColor = UIColorRGBA(255, 240, 214, 1).CGColor;
        _borderView.layer.cornerRadius = 2.0f;
        _borderView.clipsToBounds = YES;
    }
    return _borderView;
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
        _fanLab.text = @"20%推广费";
    }
    return _fanLab;
}
-(UILabel *)countLab
{
    if (!_countLab) {
        _countLab = [[UILabel alloc] init];
        _countLab.textColor = LYColor_A4;
        _countLab.font = [UIFont systemFontOfSize:12*WEIGHT];
        _countLab.text = @"销量 12万份";
        _countLab.textAlignment = NSTextAlignmentRight;
    }
    return _countLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
