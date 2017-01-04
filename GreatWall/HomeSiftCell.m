//
//  HomeSiftCell.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "HomeSiftCell.h"
#import "BezierPathLine.h"

@implementation HomeSiftCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeSiftCell";
    HomeSiftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initAnyThingWith:cell];
    }
    return cell;
}
-(void)initAnyThingWith:(HomeSiftCell *)cell
{
    [cell.contentView addSubview:self.lineView];
    [cell.contentView addSubview:self.bezierView];
    __weak HomeSiftCell *view= cell;
    
    [cell.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).with.offset(-24*WEIGHT);
        make.top.equalTo(view).with.offset(21*HEIGHT);
        make.height.equalTo(@(90*HEIGHT));
        make.width.equalTo(@(120*WEIGHT));
    }];
    [cell.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(24*WEIGHT);
        make.centerY.equalTo(self.titleImg);
        make.right.equalTo(view).with.offset(-13*WEIGHT);
        make.height.equalTo(@(11*HEIGHT));
    }];
    [cell.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.desLab);
        make.bottom.mas_equalTo(self.desLab.mas_top).with.offset(-11*HEIGHT);
        make.height.equalTo(@(16*HEIGHT));
        make.right.equalTo(view).with.offset(-13*WEIGHT);
    }];
    [cell.contentView addSubview:self.amountKindLab];
    [self.amountKindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 18));
    }];
    [cell.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountKindLab.mas_right);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(11*HEIGHT);
        make.width.equalTo(@(60*WEIGHT));
        make.height.equalTo(@(16*HEIGHT));
    }];
    [cell.contentView addSubview:self.qiLab];
    [self.qiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(14*WEIGHT, 14*HEIGHT));
    }];
    [cell.contentView addSubview:self.fanImg];
    [self.fanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qiLab.mas_right).with.offset(16*WEIGHT);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(11*HEIGHT);
        make.height.equalTo(@(17*HEIGHT));
        make.width.equalTo(@(80*WEIGHT));
    }];
    [cell.contentView addSubview:self.fanLab];
    [self.fanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.fanImg);
        make.size.mas_equalTo(CGSizeMake(60*WEIGHT, 11*HEIGHT));
    }];

}
-(void)setIndexPathRow:(NSInteger)indexPathRow
{
    if (indexPathRow==0) {
        self.lineView.hidden = NO;
        self.bezierView.hidden = YES;
    }else{
        self.lineView.hidden = YES;
        self.bezierView.hidden = NO;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HomeCellModel *)model
{
    [self.titleImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"01.jpg"]];
    
    CGRect tempRect = [self.amountLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-ScreenWindowWidth/3-65,25)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17*HEIGHT]}context:nil];
    [self.amountLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tempRect.size.width+5));
    }];
    [self layoutIfNeeded];
}
#pragma mark  -------Controller-------------
-(UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01.jpg"]];
    }
    return _titleImg;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16*HEIGHT];
        _titleLab.textColor = LYColor_A3;
        _titleLab.text = @"少儿意外医疗险";
    }
    return _titleLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab =[[UILabel alloc] init];
        _desLab.font = [UIFont systemFontOfSize:11*HEIGHT];
        _desLab.textColor = [UIColor lightGrayColor];
        _desLab.text = @"5万人身意外/5千医疗保障";
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
        _amountLab.text = @"100";
    }
    return _amountLab;
}
-(UILabel *)amountKindLab
{
    if (!_amountKindLab) {
        _amountKindLab =[[UILabel alloc] init];
        _amountKindLab.font = [UIFont systemFontOfSize:14*WEIGHT];
        _amountKindLab.textColor = LYColor_A1;
        _amountKindLab.text = @"¥";
    }
    return _amountKindLab;
}
-(UIImageView *)fanImg
{
    if (!_fanImg) {
        _fanImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tuiguangfeibiaoqian"]];
    }
    return _fanImg;
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
-(ImaginaryLine *)lineView
{
    if (!_lineView) {
        _lineView = [[ImaginaryLine alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 132*HEIGHT)];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}
-(BezierPathLine *)bezierView
{
    if (!_bezierView) {
        _bezierView = [[BezierPathLine alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 132*HEIGHT)];
        _bezierView.backgroundColor = [UIColor whiteColor];
    }
    return _bezierView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
