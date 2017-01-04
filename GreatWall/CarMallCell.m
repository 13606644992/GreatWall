//
//  CarMallCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/3.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CarMallCell.h"

@implementation CarMallCell
+(instancetype)MallcellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CarMallCell";
    CarMallCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
    [self.contentView addSubview:self.borderView];
    [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.areaLab.mas_bottom).with.offset(13*HEIGHT);
        make.width.equalTo(@(80*WEIGHT));
        make.height.equalTo(@(24*HEIGHT));
    }];
    [self.contentView addSubview:self.brandLab];
    [self.brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.borderView);
        make.size.mas_equalTo(CGSizeMake(56*HEIGHT, 16*HEIGHT));
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
    CGRect tempRectBrand = [self.brandLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-220,11*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11*WEIGHT]}context:nil];
    [self.borderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(tempRectBrand.size.width+28*WEIGHT, 24*HEIGHT));
    }];
    [self.brandLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(tempRectBrand.size.width+22*WEIGHT, 18*HEIGHT));
    }];
    [self layoutIfNeeded];
    
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
        //        _titleLab.backgroundColor = [UIColor redColor];
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
-(UILabel *)brandLab
{
    if (!_brandLab) {
        _brandLab = [[UILabel alloc] init];
        _brandLab.textColor = [LYColor colorWithHexString:@"#ffae22"];
        _brandLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _brandLab.textAlignment = NSTextAlignmentCenter;
        _brandLab.backgroundColor = UIColorRGBA(255, 240, 214, 1);
        _brandLab.text = @"中国平安";
        _brandLab.layer.cornerRadius = 2.0f;
        _brandLab.clipsToBounds = YES;
    }
    return _brandLab;
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
