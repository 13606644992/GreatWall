//
//  DescriptionTypeTwoCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DescriptionTypeTwoCell.h"

@implementation DescriptionTypeTwoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DescriptionTypeTwoCell";
    
    DescriptionTypeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
        make.top.equalTo(self.contentView).with.offset(17.5*HEIGHT);
        make.width.equalTo(@(120*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.detialImg];
    [self.detialImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-18*WIDTH);
        make.centerY.equalTo(self.titleLab);
        make.width.equalTo(@(12.5*WIDTH));
        make.height.equalTo(@(7.5*HEIGHT));
    }];

    [self.contentView addSubview:self.detialLab];
    [self.detialLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.detialImg.mas_left).with.offset(-6*WIDTH);
        make.top.equalTo(self.contentView).with.offset(17.5*HEIGHT);
        make.width.equalTo(@(120*WIDTH));
        make.height.equalTo(@(14*HEIGHT));
    }];
    [self.contentView addSubview:self.detailButton];
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.detialImg);
        make.top.equalTo(self.contentView);
        make.width.equalTo(@(120*WIDTH));
        make.height.equalTo(@(49*HEIGHT));
    }];
    
    
}
-(CGFloat)cellHeight
{
    if (!self.isOpen) {
        NSLog(@"------------");

        return 49*HEIGHT;
    }else{
        return 98*HEIGHT;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)searchClick:(UIButton *)sender
{
    self.isOpen = !self.isOpen;
    NSLog(@"------------");
    //发送消息
}
#pragma mark ---------Controller-------------
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A3;
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.text = @"保障时间";
    }
    return _titleLab;
}
-(UIImageView *)detialImg
{
    if (!_detialImg) {
        _detialImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xialaicon"]];
    }
    return _detialImg;
}
-(UILabel *)detialLab
{
    if (!_detialLab) {
        _detialLab = [[UILabel alloc] init];
        _detialLab.textColor = LYColor_A3;
        _detialLab.textAlignment = NSTextAlignmentRight;
        _detialLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _detialLab.text = @"1-7天";
    }
    return _detialLab;
}
-(UIButton *)detailButton
{
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _detailButton;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
    
    // Configure the view for the selected state
}
@end
