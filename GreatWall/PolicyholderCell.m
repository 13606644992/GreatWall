//
//  PolicyholderCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "PolicyholderCell.h"

@implementation PolicyholderCell
+ (instancetype)cellWithThePolicyHoderTableView:(UITableView *)tableView
{
    static NSString *ID = @"PolicyholderCell";
    PolicyholderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadThePolicyHoderViewWithCell];
    }
    return cell;
}
-(void)loadThePolicyHoderViewWithCell
{
    
    [self.contentView addSubview:self.nameOne];
    [self.nameOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(@(24*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(70*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.cardTypeTwo];
    [self.cardTypeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameOne);
        make.top.mas_equalTo(self.nameOne.mas_bottom).with.offset(12*HEIGHT);
        make.size.equalTo(self.nameOne);
    }];
    [self.contentView addSubview:self.cardNumThree];
    [self.cardNumThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameOne);
        make.top.mas_equalTo(self.cardTypeTwo.mas_bottom).with.offset(12*HEIGHT);
        make.size.equalTo(self.nameOne);
    }];
    [self.contentView addSubview:self.phoneFour];
    [self.phoneFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameOne);
        make.top.mas_equalTo(self.cardNumThree.mas_bottom).with.offset(12*HEIGHT);
        make.size.equalTo(self.nameOne);
    }];
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(96*WIDTH));
        make.top.equalTo(@(24*HEIGHT));
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.cardType];
    [self.cardType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.top.equalTo(self.cardTypeTwo);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.cardNum];
    [self.cardNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.top.equalTo(self.cardNumThree);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.phoneNum];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.top.equalTo(self.phoneFour);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTrade:(PayTrade *)trade
{
    self.selectColor = LYColor_A3;
    if ([trade.sts isEqualToString:@"-11"]) {
        self.selectColor = LYColor_A4;
    }
    self.nameLab.textColor = self.selectColor;
    self.nameLab.text = trade.applicant;
    self.cardType.textColor = self.selectColor;
    self.cardType.text = self.cards[[trade.applicantType integerValue]];
    self.cardNum.textColor = self.selectColor;
    self.cardNum.text = trade.applicantIdNo;
    self.phoneNum.textColor = self.selectColor;
    self.phoneNum.text = trade.applicantMobile;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}
#pragma mark ---------Controller-------------
-(UILabel *)nameOne
{
    if (!_nameOne) {
        _nameOne = [[UILabel alloc] init];
        _nameOne.textColor = LYColor_A4;
        _nameOne.font = [UIFont systemFontOfSize:14*WIDTH];
        _nameOne.text = @"姓名:";
    }
    return _nameOne;
}
-(UILabel *)cardTypeTwo
{
    if (!_cardTypeTwo) {
        _cardTypeTwo = [[UILabel alloc] init];
        _cardTypeTwo.textColor = LYColor_A4;
        _cardTypeTwo.font = [UIFont systemFontOfSize:14*WIDTH];
        _cardTypeTwo.text = @"证件类型:";
    }
    return _cardTypeTwo;
}
-(UILabel *)cardNumThree
{
    if (!_cardNumThree) {
        _cardNumThree = [[UILabel alloc] init];
        _cardNumThree.textColor = LYColor_A4;
        _cardNumThree.font = [UIFont systemFontOfSize:14*WIDTH];
        _cardNumThree.text = @"证件号码:";
    }
    return _cardNumThree;
}
-(UILabel *)phoneFour
{
    if (!_phoneFour) {
        _phoneFour = [[UILabel alloc] init];
        _phoneFour.textColor = LYColor_A4;
        _phoneFour.font = [UIFont systemFontOfSize:14*WIDTH];
        _phoneFour.text = @"手机号码:";
    }
    return _phoneFour;
}
-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = LYColor_A3;
        _nameLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _nameLab.text = @"铁拐李";
    }
    return _nameLab;
}
-(UILabel *)cardType
{
    if (!_cardType) {
        _cardType = [[UILabel alloc] init];
        _cardType.textColor = LYColor_A3;
        _cardType.font = [UIFont systemFontOfSize:14*WIDTH];
        _cardType.text = @"身份证";
    }
    return _cardType;
}
-(UILabel *)cardNum
{
    if (!_cardNum) {
        _cardNum = [[UILabel alloc] init];
        _cardNum.textColor = LYColor_A3;
        _cardNum.font = [UIFont systemFontOfSize:14*WIDTH];
        _cardNum.text = @"123456789087654";
    }
    return _cardNum;
}
-(UILabel *)phoneNum
{
    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc] init];
        _phoneNum.textColor = LYColor_A3;
        _phoneNum.font = [UIFont systemFontOfSize:14*WIDTH];
        _phoneNum.text = @"12345678901";
    }
    return _phoneNum;
}
-(NSArray *)cards
{
    if (!_cards) {
        _cards = @[@"其他",@"身份证",@"军官证",@"护照",@"驾驶证",@"港澳台通行证/回乡证"];
    }
    return _cards;
}

@end
