//
//  SearchCell.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/23.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SearchCell";
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initSearchCellAnyThingWith];
    }
    return cell;
}
-(void)initSearchCellAnyThingWith
{
    [self.contentView addSubview:self.hotImg];
    [self.hotImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*HEIGHT);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(17*WEIGHT, 17*HEIGHT));
    }];
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hotImg.mas_right).with.offset(10*HEIGHT);
        make.centerY.equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-80*WEIGHT);
        make.height.equalTo(@(16*HEIGHT));
    }];
    [self.contentView addSubview:self.removeImg];
    [self.removeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-18*HEIGHT);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(9*WEIGHT, 9.5*HEIGHT));
    }];
    [self.contentView addSubview:self.removeBtn];
    [self.removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-9*HEIGHT);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(30*WEIGHT, 40*HEIGHT));
    }];
}
-(void)setModel:(SearchModel *)Model
{

}
#pragma mark ---------Controller--------
-(UIImageView *)hotImg
{
    if (!_hotImg) {
        _hotImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shijian(sousuoyemian)"]];
    }
    return _hotImg;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.text = @"汇保险";
        _titleLab.font = [UIFont systemFontOfSize:14*HEIGHT];
        _titleLab.textColor = LYColor_A3;
    }
    return _titleLab;
}
-(UIImageView *)removeImg
{
    if (!_removeImg) {
        _removeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shanchu(lishisousuolan)"]];
    }
    return _removeImg;
}
-(UIButton *)removeBtn
{
    if (!_removeBtn) {
        _removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _removeBtn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
