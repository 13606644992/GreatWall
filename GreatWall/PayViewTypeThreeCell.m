//
//  PayViewTypeThreeCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "PayViewTypeThreeCell.h"

@implementation PayViewTypeThreeCell
+ (instancetype)cellWithPayViewTypeTableView:(UITableView *)tableView
{
    static NSString *ID = @"PayViewTypeThreeCell";
    PayViewTypeThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadPayViewTypeThreeWithCell];
    }
    return cell;
}
-(void)loadPayViewTypeThreeWithCell
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(80*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.styleImg];
    [self.styleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(6*WIDTH, 10*HEIGHT));
    }];
    [self.contentView addSubview:self.detailLab];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.styleImg.mas_left).with.offset(-6*WIDTH);
        make.left.mas_equalTo(self.titleLab.mas_right).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(14*HEIGHT));
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
        _titleLab.text = @"红包抵扣";
    }
    return _titleLab;
}
-(UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] init];
        _detailLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _detailLab.textAlignment = NSTextAlignmentRight;
        _detailLab.textColor = LYColor_A1;
//        _detailLab.text = @"省5元：每周首单红包";
        _detailLab.text = @"";

    }
    return _detailLab;
}
-(UIImageView *)styleImg{
    if (!_styleImg) {
        _styleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    }
    return _styleImg;
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
