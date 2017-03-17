//
//  ApplicantCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/6.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ApplicantCell.h"

@implementation ApplicantCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ApplicantCell";
    
    ApplicantCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initWithTheApplication];
    }
    return cell;
}
-(void)initWithTheApplication
{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.personButton];
    [self.personButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-18*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(23*WIDTH, 24*WIDTH));
    }];
    [self.contentView addSubview:self.detailTF];
    [self.detailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(128*WIDTH);
        make.centerY.equalTo(self.contentView);
        make.right.mas_equalTo(self.personButton.mas_left).with.offset(20*WIDTH);
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
-(UIButton *)personButton
{
    if (!_personButton) {
        _personButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_personButton setImage:[UIImage imageNamed:@"tianjialianxiren"] forState:UIControlStateNormal];
    }
    return _personButton;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
