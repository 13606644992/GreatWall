//
//  DescriptionCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DescriptionCell.h"
#import "DescriptionTypeTwoCell.h"

@implementation DescriptionCell
//初始方法
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DescriptionCell";
    DescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initAnyThingWithCell];
    }
    return cell;
}
-(void)initAnyThingWithCell
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(120*WIDTH));
        make.height.equalTo(@(14*HEIGHT));

    }];
    [self.contentView addSubview:self.detialLab];
    [self.detialLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(120*WIDTH));
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
        _titleLab.text = @"投保年龄";
    }
    return _titleLab;
}
-(UILabel *)detialLab
{
    if (!_detialLab) {
        _detialLab = [[UILabel alloc] init];
        _detialLab.textColor = LYColor_A3;
        _detialLab.textAlignment = NSTextAlignmentRight;
        _detialLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _detialLab.text = @"18-85岁";
    }
    return _detialLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
