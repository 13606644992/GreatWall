//
//  PayViewTypeSevenCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "PayViewTypeSevenCell.h"

@implementation PayViewTypeSevenCell
+ (instancetype)cellWithPayViewTypeSevenTableView:(UITableView *)tableView
{
    static NSString *ID = @"PayViewTypeSixCell";
    PayViewTypeSevenCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadPayViewTypeSevenWithCell];
    }
    return cell;
}
-(void)loadPayViewTypeSevenWithCell
{
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(19*WIDTH, 19*WIDTH));
    }];
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn.mas_right).with.offset(11*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(-18*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
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
        _titleLab.text = @"支付宝支付";
    }
    return _titleLab;
}
-(UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.userInteractionEnabled = NO;
        [_selectBtn setImage:[UIImage imageNamed:@"weigouxuan(xincheweishangpai)"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"gouxuanxincheweishangpai"] forState:UIControlStateSelected];
    }
    return _selectBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
