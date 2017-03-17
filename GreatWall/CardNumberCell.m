//
//  CardNumberCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CardNumberCell.h"

@implementation CardNumberCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CardNumberCell";
    
    CardNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initWithTheCardNumber];
    }
    return cell;
}
-(void)initWithTheCardNumber
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(23*WIDTH, 24*WIDTH));
    }];
    [self.contentView addSubview:self.detailTF];
    [self.detailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(128*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.selectButton).with.offset(-20*WIDTH);
        make.height.equalTo(@(13*HEIGHT));
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
    }
    return _titleLab;
}
-(UITextField *)detailTF
{
    if (!_detailTF) {
        _detailTF = [[UITextField alloc] init];
        _detailTF.font = [UIFont systemFontOfSize:13*WIDTH];
    }
    return _detailTF;
}
-(UIButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"xialaicon"] forState:UIControlStateNormal];
    }
    return _selectButton;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
