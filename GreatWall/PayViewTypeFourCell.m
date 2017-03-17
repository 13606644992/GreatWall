//
//  PayViewTypeFourCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "PayViewTypeFourCell.h"

@implementation PayViewTypeFourCell
+(instancetype)cellWithPayViewTypeFourTableView:(UITableView *)tableView
{
    static NSString *ID = @"PayViewTypeFourCell";
    PayViewTypeFourCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadPayViewTypeFourWithCell];
    }
    return cell;
}
-(void)loadPayViewTypeFourWithCell
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(260*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.segementBtn];
    [self.segementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40*WIDTH, 24*HEIGHT));
    }];
    [self.contentView addSubview:self.lineLab];
    [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
        make.left.equalTo(@(18*WIDTH));
        make.height.equalTo(@(0.5f));
    }];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
        _titleLab.textColor = LYColor_A3;
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.text = @"可用1160积分抵¥11.60";
    }
    return _titleLab;
}
-(UIButton *)segementBtn
{
    if (!_segementBtn) {
        _segementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_segementBtn setImage:[UIImage imageNamed:@"off"] forState:UIControlStateNormal];
        [_segementBtn setImage:[UIImage imageNamed:@"on"] forState:UIControlStateSelected];
    }
    return _segementBtn;
}
-(UILabel *)lineLab
{
    if (!_lineLab) {
        _lineLab = [[UILabel alloc] init];
        _lineLab.backgroundColor = LYColor_A7;
    }
    return _lineLab;
}

@end
