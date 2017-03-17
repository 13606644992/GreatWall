//
//  FriendCell.m
//  YaoQingHaoYou
//
//  Created by LeeGJ on 17/3/8.
//  Copyright © 2017年 LeeGJ. All rights reserved.
//

#import "FriendCell.h"
#import "Header.h"
#import "YaoQingModel.h"
@implementation FriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}
- (void)creatSubView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(15*WIDTH);
        make.height.mas_equalTo(12*HEIGHT);
        make.width.mas_equalTo(30*WIDTH);
    }];
    [self.contentView addSubview:self.headIMG];
    [self.headIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(50*WIDTH);
        make.size.mas_equalTo(CGSizeMake(42*WIDTH, 42*WIDTH));
    }];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.headIMG.mas_right).offset(15*WIDTH);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 20*HEIGHT));
    }];
    [self.contentView addSubview:self.income];
    [self.income mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15*HEIGHT);
        make.centerX.mas_equalTo(120*WIDTH);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 18*HEIGHT));
    }];
    UILabel *myLab = [[UILabel alloc]init];
    myLab.text = @"推荐收入(元)";
    myLab.textColor = [UIColor lightGrayColor];
    myLab.textAlignment = NSTextAlignmentCenter;
    myLab.font = [UIFont systemFontOfSize:11*HEIGHT];
    [self.contentView addSubview:myLab];
    [myLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.income);
        make.bottom.mas_equalTo(-15*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 11*HEIGHT));
    }];
}

- (void)setYaoQingModel:(YaoQingModel *)yaoQingModel{
    [self.headIMG sd_setImageWithURL:[NSURL URLWithString:yaoQingModel.userLogo] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
    self.name.text = yaoQingModel.userNickname;
    self.income.text = [ NSString stringWithFormat:@"%@",yaoQingModel.acctSum];
}

- (UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc]init];
        _number.textColor = [UIColor lightGrayColor];
        _number.font = [UIFont systemFontOfSize:16*HEIGHT];
    }
    return _number;
}
- (UIImageView *)headIMG{
    if (!_headIMG) {
        _headIMG = [[UIImageView alloc]init];
        _headIMG.layer.cornerRadius = 21*WIDTH;
        _headIMG.clipsToBounds = YES;
    }
    return _headIMG;
}
- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.textColor = [UIColor blackColor];
        _name.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _name;
}
- (UILabel *)income{
    if (!_income) {
        _income = [[UILabel alloc]init];
        _income.textColor = [UIColor blackColor];
        _income.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*HEIGHT];
        _income.textAlignment = NSTextAlignmentCenter;
    }
    return _income;
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
