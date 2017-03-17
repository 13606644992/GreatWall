//
//  ChangeCarTypeCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ChangeCarTypeCell.h"
#import "Header.h"

@implementation ChangeCarTypeCell
+(instancetype)ChangeCarTypecellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ChangeCarTypeCell";
    ChangeCarTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor whiteColor];
        [cell loadTheChangeTypeWithCar];
    }
    return cell;
}
-(void)loadTheChangeTypeWithCar{
    
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(105*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.xiaImg];
    [self.xiaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-18*WIDTH);
        make.centerY.equalTo(self.titleLab);
        make.width.equalTo(@(12.5*WIDTH));
        make.height.equalTo(@(7.5*HEIGHT));
    }];
    [self.contentView addSubview:self.touLab];
    [self.touLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.xiaImg.mas_left).with.offset(-6*WIDTH);
        make.centerY.equalTo(self.titleLab);
        make.size.mas_equalTo(CGSizeMake(60*WIDTH, 14*HEIGHT));
    }];
    [self.contentView addSubview:self.touBtn];
    [self.touBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 40*HEIGHT));
    }];
    
    [self.contentView addSubview:self.mianBtn];
    [self.mianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 50*HEIGHT));
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
#pragma mark  -----Controller-------
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.textColor = LYColor_A3;
        _titleLab.text = @"交强险";
    }
    return _titleLab;
}
-(UIImageView *)xiaImg{
    if (!_xiaImg) {
        _xiaImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xialaicon"]];
    }
    return _xiaImg;
}
-(UILabel *)touLab{
    if (!_touLab) {
        _touLab = [[UILabel alloc] init];
        _touLab.textColor = LYColor_A3;
        _touLab.text = @"不投保";
        _touLab.textAlignment = NSTextAlignmentRight;
        _touLab.font = [UIFont systemFontOfSize:14*WIDTH];
    }
    return _touLab;
}
-(UIButton *)touBtn{
    if (!_touBtn) {
        _touBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _touBtn;
}
-(UIButton *)mianBtn{
    if (!_mianBtn) {
        _mianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mianBtn.backgroundColor = [UIColor clearColor];
        [_mianBtn setImage:[UIImage imageNamed:@"gouxuanxincheweishangpai"] forState:UIControlStateNormal];
        [_mianBtn setImage:[UIImage imageNamed:@"weigouxuan(xincheweishangpai)"] forState:UIControlStateSelected];
        _mianBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
        [_mianBtn setTitle:@"不计免赔" forState:UIControlStateNormal];
        _mianBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _mianBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_mianBtn setTitleColor:LYColor_A4 forState:UIControlStateNormal];
    }
    return _mianBtn;
}
@end
