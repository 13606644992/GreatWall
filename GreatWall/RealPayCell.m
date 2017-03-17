//
//  RealPayCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/23.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "RealPayCell.h"

@implementation RealPayCell
+ (instancetype)cellWithTheRealPayTableView:(UITableView *)tableView
{
    static NSString *ID = @"RealPayCell";
    RealPayCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadTheRealPayViewWithCell];
    }
    return cell;
}
-(void)loadTheRealPayViewWithCell
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(170*WIDTH, 14*HEIGHT));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTrade:(PayTrade *)trade
{
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}
#pragma mark ---------Controller-------------
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A4;
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.text = @"实付金额";
    }
    return _titleLab;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] init];
        _amountLab.textColor = LYColor_A2;
        _amountLab.font = [UIFont systemFontOfSize:19*WIDTH];
        _amountLab.textAlignment = NSTextAlignmentRight;
        _amountLab.text = @"¥99.40";
    }
    return _amountLab;
}

@end
