//
//  DescriptionTypeSexCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DescriptionTypeSexCell.h"

@implementation DescriptionTypeSexCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DescriptionTypeSexCell";
    
    DescriptionTypeSexCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
    
    [self.contentView addSubview:self.mainBtn];
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(18*WIDTH);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(13*HEIGHT);
        make.width.equalTo(@(60*WIDTH));
        make.height.equalTo(@(20*HEIGHT));
    }];
    [self.contentView addSubview:self.womanBtn];
    [self.womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainBtn.mas_right).with.offset(18*WIDTH);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(13*HEIGHT);
        make.width.equalTo(@(60*WIDTH));
        make.height.equalTo(@(20*HEIGHT));
    }];
    self.mainBtn.hidden = YES;
    self.womanBtn.hidden = YES;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//-(void)sexSelect:(UIButton *)sender
//{
//    switch (sender.tag) {
//        case 1:
//        {
//            self.detialLab.text = @"男";
//        }
//            break;
//        case 2:
//        {
//            self.detialLab.text = @"女";
//        }
//            break;
//        default:
//            break;
//    }
//}
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
-(UIButton *)mainBtn
{
    if (!_mainBtn) {
        _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mainBtn.backgroundColor = LYColor_A2;
        [_mainBtn setTitle:@"男" forState:UIControlStateNormal];
        [_mainBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
//        [_mainBtn addTarget:self action:@selector(sexSelect:) forControlEvents:UIControlEventTouchUpInside];
        _mainBtn.tag = 1;
        _mainBtn.layer.cornerRadius = 10.0f;
        _mainBtn.clipsToBounds = YES;
    }
    return _mainBtn;
}
-(UIButton *)womanBtn
{
    if (!_womanBtn) {
        _womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _womanBtn.backgroundColor = LYColor_A2;
        [_womanBtn setTitle:@"女" forState:UIControlStateNormal];
        [_womanBtn setTitleColor:LYColor_A1 forState:UIControlStateNormal];
//        [_womanBtn addTarget:self action:@selector(sexSelect:) forControlEvents:UIControlEventTouchUpInside];
        _womanBtn.layer.cornerRadius = 10.0f;
        _womanBtn.clipsToBounds = YES;
        _womanBtn.tag = 2;
    }
    return _womanBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
    
    // Configure the view for the selected state
}


@end
