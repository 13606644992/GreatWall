//
//  ReducePayCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/23.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ReducePayCell.h"

@implementation ReducePayCell
+ (instancetype)cellWithTheReducePayCellTableView:(UITableView *)tableView
{
    static NSString *ID = @"PolicyholderCell";
    ReducePayCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadTheReducePayViewWithCell];
    }
    return cell;
}
-(void)loadTheReducePayViewWithCell
{
    [self.contentView addSubview:self.insureLab];
    [self.insureLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(@(21*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.redPackedLab];
    [self.redPackedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.insureLab.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.yueLab];
    [self.yueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(self.redPackedLab.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.insureAmount];
    [self.insureAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.top.equalTo(@(21*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.reduceRedPacked];
    [self.reduceRedPacked mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.top.mas_equalTo(self.insureAmount.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.reduceYue];
    [self.reduceYue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.top.mas_equalTo(self.redPackedLab.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.linelab];
    [self.linelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(0.5));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTrade:(PayTrade *)trade
{
    self.insureAmount.text = trade.sumPremium;
    
//    self.
    
    
}
#pragma mark ---------Controller-------------
-(UILabel *)insureLab
{
    if (!_insureLab) {
        _insureLab = [[UILabel alloc] init];
        _insureLab.textColor = LYColor_A4;
        _insureLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _insureLab.text = @"保费总额";
    }
    return _insureLab;
}
-(UILabel *)redPackedLab
{
    if (!_redPackedLab) {
        _redPackedLab = [[UILabel alloc] init];
        _redPackedLab.textColor = LYColor_A4;
        _redPackedLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _redPackedLab.text = @"-红包抵扣";
    }
    return _redPackedLab;
}
-(UILabel *)yueLab
{
    if (!_yueLab) {
        _yueLab = [[UILabel alloc] init];
        _yueLab.textColor = LYColor_A4;
        _yueLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _yueLab.text = @"-余额抵扣";
    }
    return _yueLab;
}
-(UILabel *)insureAmount
{
    if (!_insureAmount) {
        _insureAmount = [[UILabel alloc] init];
        _insureAmount.textColor = LYColor_A2;
        _insureAmount.font = [UIFont systemFontOfSize:14*WIDTH];
        _insureAmount.text = @"¥116.00";
        _insureAmount.textAlignment = NSTextAlignmentRight;

    }
    return _insureAmount;
}
-(UILabel *)reduceRedPacked
{
    if (!_reduceRedPacked) {
        _reduceRedPacked = [[UILabel alloc] init];
        _reduceRedPacked.textColor = LYColor_A2;
        _reduceRedPacked.font = [UIFont systemFontOfSize:14*WIDTH];
        _reduceRedPacked.textAlignment = NSTextAlignmentRight;
        _reduceRedPacked.text = @"¥11.60";
    }
    return _reduceRedPacked;
}
-(UILabel *)reduceYue
{
    if (!_reduceYue) {
        _reduceYue = [[UILabel alloc] init];
        _reduceYue.textColor = LYColor_A2;
        _reduceYue.font = [UIFont systemFontOfSize:14*WIDTH];
        _reduceYue.text = @"¥5.00";
        _reduceYue.textAlignment = NSTextAlignmentRight;
    }
    return _reduceYue;
}
-(UILabel *)linelab
{
    if (!_linelab) {
        _linelab = [[UILabel alloc] init];
        _linelab.backgroundColor = LYColor_A7;
    }
    return _linelab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
