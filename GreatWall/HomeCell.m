//
//  HomeCell.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "HomeCell.h"
@implementation HomeCell
//初始方法
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initAnyThingWithCell];
    }
    return cell;
}
//添加控件集约束
-(void)initAnyThingWithCell
{
//    底部虚线
    [self.contentView addSubview:self.lineView];
//    标题图片
    [self.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(13*WEIGHT);
        make.top.equalTo(self.contentView).with.offset(21*HEIGHT);
//        make.bottom.equalTo(self.contentView).with.offset(-21*HEIGHT);
        make.height.equalTo(@(90*HEIGHT));
        make.width.equalTo(@(120*WEIGHT));
    }];
//    描述文字
    [self.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleImg.mas_right).with.offset(13*WEIGHT);
        make.centerY.equalTo(self.titleImg);
        make.right.equalTo(self.contentView).with.offset(-13*WEIGHT);
        make.height.equalTo(@(11*HEIGHT));
    }];
//    标题
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.desLab);
        make.bottom.mas_equalTo(self.desLab.mas_top).with.offset(-11*HEIGHT);
        make.height.equalTo(@(16*HEIGHT));
        make.right.equalTo(self.contentView).with.offset(-13*WEIGHT);
    }];
//    金额种类
    [self.contentView addSubview:self.rmbLab];
    [self.rmbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.desLab);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(14*WEIGHT, 14*HEIGHT));
    }];
//    金额
    [self.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rmbLab.mas_right);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(11*HEIGHT);
        make.width.equalTo(@(60*WEIGHT));
        make.height.equalTo(@(16*HEIGHT));
    }];
//    起
    [self.contentView addSubview:self.qiLab];
    [self.qiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(14*WEIGHT, 14*HEIGHT));
    }];
//    返现背景图
    [self.contentView addSubview:self.fanImg];
    [self.fanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qiLab.mas_right).with.offset(16*WEIGHT);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(11*HEIGHT);
        make.height.equalTo(@(17*HEIGHT));
        make.width.equalTo(@(80*WEIGHT));
    }];
//    返现金额比例
    [self.contentView addSubview:self.fanLab];
    [self.fanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.fanImg);
        make.size.mas_equalTo(CGSizeMake(60*WEIGHT, 11*HEIGHT));
    }];
}
//虚线是否隐藏
-(void)setIndexPathRow:(NSInteger)indexPathRow
{
    if (indexPathRow == 2) {
        self.lineView.hidden = YES;
    }else{
        self.lineView.hidden = NO;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//属性赋值以及约束条件更新
-(void)setModel:(HomeCellModel *)model
{
    [self.titleImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"01.jpg"]];
    CGRect tempRect = [self.amountLab.text   boundingRectWithSize:CGSizeMake(100*WEIGHT,16*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16*HEIGHT]}context:nil];
    [self.amountLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tempRect.size.width+5*WEIGHT));
    }];
    [self layoutIfNeeded];
}
#pragma mark  -------Controller
-(UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01.jpg"]];
    }
    return _titleImg;
}
-(UIImageView *)fanImg
{
    if (!_fanImg) {
        _fanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tuiguangfeibiaoqian"]];
    }
    return _fanImg;
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
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16*WEIGHT];
        _titleLab.textColor = LYColor_A3;
        _titleLab.text = @"至尊车险";
    }
    return _titleLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab =[[UILabel alloc] init];
        _desLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _desLab.textColor = LYColor_A4;
        _desLab.text = @"超值保障/全国通赔";
    }
    return _desLab;
}
-(UILabel *)fanLab
{
    if (!_fanLab) {
        _fanLab =[[UILabel alloc] init];
        _fanLab.font = [UIFont systemFontOfSize:11*WEIGHT];
        _fanLab.textColor = [LYColor colorWithHexString:@"ffffff"];
        _fanLab.textAlignment = NSTextAlignmentCenter;
        _fanLab.text = @"25%推广费";
    }
    return _fanLab;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab =[[UILabel alloc] init];
        _amountLab.font = [UIFont systemFontOfSize:16*WEIGHT];
        _amountLab.textColor = LYColor_A1;
        _amountLab.text = @"2500";
    }
    return _amountLab;
}
-(UILabel *)qiLab
{
    if (!_qiLab) {
        _qiLab =[[UILabel alloc] init];
        _qiLab.font = [UIFont systemFontOfSize:14*WEIGHT];
        _qiLab.textColor = LYColor_A4;
        _qiLab.text = @"起";
    }
    return _qiLab;
}
-(OnlyLine *)lineView
{
    if (!_lineView) {
        _lineView = [[OnlyLine alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 132*HEIGHT)];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end