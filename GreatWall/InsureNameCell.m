//
//  InsureNameCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/22.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "InsureNameCell.h"

@implementation InsureNameCell
+ (instancetype)cellWithTheInsureNameTableView:(UITableView *)tableView
{
    static NSString *ID = @"InsuredPerCell";
    InsureNameCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell loadTheInsureNameViewWithCell];
    }
    return cell;
}
-(void)loadTheInsureNameViewWithCell
{
    [self.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.equalTo(@(21*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(21*WIDTH, 23.5*HEIGHT));
    }];
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleImg.mas_right).with.offset(18*WIDTH);
        make.centerY.equalTo(self.titleImg);
        make.width.equalTo(@(150*WIDTH));
        make.height.equalTo(@(21*HEIGHT));
    }];
    [self.contentView addSubview:self.rightImg];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).with.offset(13*WIDTH);
        make.centerY.equalTo(self.titleImg);
        make.width.equalTo(@(6*WIDTH));
        make.height.equalTo(@(10*HEIGHT));
    }];
    [self.contentView addSubview:self.linelab];
    [self.linelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(0.5));
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTrade:(PayTrade *)trade
{
    self.selectColor = LYColor_A3;
    if ([trade.sts isEqualToString:@"-11"]) {
        self.selectColor = LYColor_A4;
    }
    self.titleLab.textColor = self.selectColor;
    self.titleLab.text = trade.productName;
    CGRect tempRect = [trade.productName  boundingRectWithSize:CGSizeMake(240*WEIGHT,21*HEIGHT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21*HEIGHT]}context:nil];
    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tempRect.size.width+5));
    }];
    
}
#pragma mark ---------Controller-------------
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        _titleLab.font = [UIFont systemFontOfSize:21*WIDTH];
        _titleLab.text = @"成人综合意外险";
    }
    return _titleLab;
}
-(UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wenjian"]];
    }
    return _titleImg;
}
-(UIImageView *)rightImg
{
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiayibu"]];
    }
    return _rightImg;
}
-(UILabel *)linelab
{
    if (!_linelab) {
        _linelab = [[UILabel alloc] init];
        _linelab.backgroundColor = LYColor_A7;
    }
    return _linelab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
