//
//  PayViewTypeTwoCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "PayViewTypeTwoCell.h"

@implementation PayViewTypeTwoCell
+ (instancetype)cellWithPayViewTypeTableView:(UITableView *)tableView
{
    static NSString *ID = @"PayViewTypeTwoCell";
    PayViewTypeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadPayViewTypeTwoWithCell];
    }
    return cell;
}
-(void)loadPayViewTypeTwoWithCell
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(250*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.styleImg];
    [self.styleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(6*WIDTH, 10*HEIGHT));
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
        _titleLab.text = @"成人综合意外险";
    }
    return _titleLab;
}
-(UIImageView *)styleImg{
    if (!_styleImg) {
        _styleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    }
    return _styleImg;
}
@end
