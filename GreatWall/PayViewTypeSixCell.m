//
//  PayViewTypeSixCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "PayViewTypeSixCell.h"

@implementation PayViewTypeSixCell
+ (instancetype)cellWithPayViewTypeSixTableView:(UITableView *)tableView
{
    static NSString *ID = @"PayViewTypeSixCell";
    PayViewTypeSixCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadPayViewTypeSixWithCell];
    }
    return cell;
}
-(void)loadPayViewTypeSixWithCell
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(90*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.left.mas_equalTo(self.titleLab.mas_right).with.offset(13*WIDTH);
        make.height.equalTo(@(14*WIDTH));
    }];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ---------Controller-------------
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.text = @"仍需支付";
    }
    return _titleLab;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] init];
        _amountLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _amountLab.textColor = LYColor_A2;
        _amountLab.textAlignment = NSTextAlignmentRight;
        _amountLab.text = @"¥99.40";
    }
    return _amountLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
