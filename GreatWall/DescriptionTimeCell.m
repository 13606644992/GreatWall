//
//  DescriptionTimeCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DescriptionTimeCell.h"

@implementation DescriptionTimeCell
+(instancetype)cellWithTimeTableView:(UITableView *)tableView
{
    static NSString *ID = @"DescriptionTimeCell";
    DescriptionTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initWithTheDescriptionTimeCount];
    }
    return cell;
}
-(void)initWithTheDescriptionTimeCount
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.detialLab];
    [self.detialLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
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
        _titleLab.text = @"起保时间";
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
    }
    return _titleLab;
}
-(UILabel *)detialLab
{
    if (!_detialLab) {
        _detialLab = [[UILabel alloc]init];
        _detialLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _detialLab.textAlignment = NSTextAlignmentRight;
        _detialLab.textColor = LYColor_A3;
    }
    return _detialLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
