//
//  PayViewTypeFiveCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "PayViewTypeFiveCell.h"

@implementation PayViewTypeFiveCell
+ (instancetype)cellWithPayViewTypeFiveTableView:(UITableView *)tableView
{
    static NSString *ID = @"PayViewTypeFiveCell";
    PayViewTypeFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadPayViewTypeFiveWithCell];
    }
    return cell;
}
-(void)loadPayViewTypeFiveWithCell
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(90*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.segementBtn];
    [self.segementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40*WIDTH, 24*HEIGHT));
    }];
    [self.contentView addSubview:self.numberLab];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(123*WIDTH));
        make.right.mas_equalTo(self.segementBtn.mas_left).with.offset(-13*WIDTH);
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
#pragma mark ---------Controller-------------
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.text = @"使用优惠券";
    }
    return _titleLab;
}
-(UILabel *)numberLab
{
    if (!_numberLab) {
        _numberLab = [[UILabel alloc]init];
        _numberLab.text = @"A39TG74JFH39";
        _numberLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _numberLab.textColor = LYColor_A4;
    }
    return _numberLab;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
