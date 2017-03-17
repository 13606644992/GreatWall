//
//  ChitInfoCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ChitInfoCell.h"

@implementation ChitInfoCell
+ (instancetype)cellWithTheChitInfoTableView:(UITableView *)tableView
{
    static NSString *ID = @"ChitInfoCell";
    ChitInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadchitInfoViewWithCell];
    }
   
    return cell;
}
-(void)loadchitInfoViewWithCell
{
    
    [self.contentView addSubview:self.orderOne];
    [self.orderOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(@(24*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(70*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.orderTwo];
    [self.orderTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderOne);
        make.top.mas_equalTo(self.orderOne.mas_bottom).with.offset(12*HEIGHT);
        make.size.equalTo(self.orderOne);
    }];
    [self.contentView addSubview:self.insureThree];
    [self.insureThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderOne);
        make.top.mas_equalTo(self.orderTwo.mas_bottom).with.offset(12*HEIGHT);
        make.size.equalTo(self.orderOne);
    }];
    [self.contentView addSubview:self.startFour];
    [self.startFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderOne);
        make.top.mas_equalTo(self.insureThree.mas_bottom).with.offset(12*HEIGHT);
        make.size.equalTo(self.orderOne);
    }];
    [self.contentView addSubview:self.endFive];
    [self.endFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderOne);
        make.top.mas_equalTo(self.startFour.mas_bottom).with.offset(12*HEIGHT);
        make.size.equalTo(self.orderOne);
    }];
    
    [self.contentView addSubview:self.orderStyle];
    [self.orderStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(96*WIDTH));
        make.top.equalTo(@(24*HEIGHT));
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.orderNum];
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderStyle);
        make.top.equalTo(self.orderTwo);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.insureNum];
    [self.insureNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderStyle);
        make.top.equalTo(self.insureThree);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.startTime];
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderStyle);
        make.top.equalTo(self.startFour);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.endTime];
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderStyle);
        make.top.equalTo(self.endFive);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    
}
-(void)setTrade:(PayTrade *)trade
{
  self.selectColor = LYColor_A3;
    NSString *string = @"";
    if ([trade.sts isEqualToString:@"-11"]) {
        self.selectColor = LYColor_A4;
        string = @"已失效";
    }else if ([trade.sts isEqualToString:@"20"]){
        string = @"已支付";
    }else{
       string = @"待支付";
    }
    self.orderStyle.text = string;
    self.orderNum.textColor = self.selectColor;
    self.orderNum.text = trade.tradeId;
    self.insureNum.textColor = self.selectColor;
    self.insureNum.text = trade.policyId;
    self.startTime.textColor = self.selectColor;
    self.startTime.text = trade.startTime;
    self.endTime.textColor = self.selectColor;
    self.endTime.text = trade.endTime;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ---------Controller-------------
-(UILabel *)orderOne
{
    if (!_orderOne) {
        _orderOne = [[UILabel alloc] init];
        _orderOne.textColor = LYColor_A4;
        _orderOne.font = [UIFont systemFontOfSize:14*WIDTH];
        _orderOne.text = @"订单状态:";
    }
    return _orderOne;
}
-(UILabel *)orderTwo
{
    if (!_orderTwo) {
        _orderTwo = [[UILabel alloc] init];
        _orderTwo.textColor = LYColor_A4;
        _orderTwo.font = [UIFont systemFontOfSize:14*WIDTH];
        _orderTwo.text = @"订单号:";
    }
    return _orderTwo;
}
-(UILabel *)insureThree
{
    if (!_insureThree) {
        _insureThree = [[UILabel alloc] init];
        _insureThree.textColor = LYColor_A4;
        _insureThree.font = [UIFont systemFontOfSize:14*WIDTH];
        _insureThree.text = @"保单号:";
    }
    return _insureThree;
}
-(UILabel *)startFour
{
    if (!_startFour) {
        _startFour = [[UILabel alloc] init];
        _startFour.textColor = LYColor_A4;
        _startFour.font = [UIFont systemFontOfSize:14*WIDTH];
        _startFour.text = @"起保时间:";
    }
    return _startFour;
}
-(UILabel *)endFive
{
    if (!_endFive) {
        _endFive = [[UILabel alloc] init];
        _endFive.textColor = LYColor_A4;
        _endFive.font = [UIFont systemFontOfSize:14*WIDTH];
        _endFive.text = @"终止时间:";
    }
    return _endFive;
}
-(UILabel *)orderStyle
{
    if (!_orderStyle) {
        _orderStyle = [[UILabel alloc] init];
        _orderStyle.textColor = LYColor_A2;
        _orderStyle.font = [UIFont systemFontOfSize:14*WIDTH];
        _orderStyle.text = @"已完成";
    }
    return _orderStyle;
}
-(UILabel *)orderNum
{
    if (!_orderNum) {
        _orderNum = [[UILabel alloc] init];
        _orderNum.textColor = LYColor_A3;
        _orderNum.font = [UIFont systemFontOfSize:14*WIDTH];
        _orderNum.text = @"123456789";
    }
    return _orderNum;
}
-(UILabel *)insureNum
{
    if (!_insureNum) {
        _insureNum = [[UILabel alloc] init];
        _insureNum.textColor = LYColor_A3;
        _insureNum.font = [UIFont systemFontOfSize:14*WIDTH];
        _insureNum.text = @"12345678900000000";
    }
    return _insureNum;
}
-(UILabel *)startTime
{
    if (!_startTime) {
        _startTime = [[UILabel alloc] init];
        _startTime.textColor = LYColor_A3;
        _startTime.font = [UIFont systemFontOfSize:14*WIDTH];
        _startTime.text = @"2017-12-13 00:00:00";
    }
    return _startTime;
}
-(UILabel *)endTime
{
    if (!_endTime) {
        _endTime = [[UILabel alloc] init];
        _endTime.textColor = LYColor_A3;
        _endTime.font = [UIFont systemFontOfSize:14*WIDTH];
        _endTime.text = @"2017-12-13 00:00:00";
    }
    return _endTime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
