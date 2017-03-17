//
//  AddressTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/1/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "Header.h"
@implementation AddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}


- (void)creatSubView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = LYColor_A7;
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(13, 0, 0, 0));
    }];
    
    [background addSubview:self.name];
    [background addSubview:self.phoneNum];
    [background addSubview:self.address];
    [background addSubview:self.moren];
    [background addSubview:self.bianji];
    [background addSubview:self.shanchu];
    [background addSubview:self.selectIMG];
    [background addSubview:self.bianjiIMG];
    [background addSubview:self.shanchuIMG];
    [background addSubview:self.line];
    [background addSubview:self.selectBtn];
    [background addSubview:self.shanchuBtn];
    [background addSubview:self.bianjiBtn];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(180*WIDTH, 14*HEIGHT));
    }];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21*HEIGHT);
        make.right.mas_equalTo(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(160*WIDTH, 14*HEIGHT));
    }];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).with.offset(14*HEIGHT);
        make.left.mas_equalTo(self.name);
        make.right.mas_equalTo(self.phoneNum);
        make.height.mas_equalTo(40*HEIGHT);
    }];
    [self.selectIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name);
        make.bottom.mas_equalTo(-15*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(15*WIDTH, 15*WIDTH));
    }];
    [self.moren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selectIMG);
        make.left.mas_equalTo(self.selectIMG.mas_right).with.offset(13*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 15*HEIGHT));
    }];
    [self.shanchu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moren);
        make.right.mas_equalTo(self.phoneNum);
        make.size.mas_equalTo(CGSizeMake(28*WIDTH, 14*HEIGHT));
    }];
    [self.shanchuIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moren);
        make.right.mas_equalTo(self.shanchu.mas_left).with.offset(-8*WIDTH);
        make.size.mas_equalTo(CGSizeMake(15*WIDTH, 15*HEIGHT));
    }];
    [self.bianji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moren);
        make.right.mas_equalTo(self.shanchuIMG.mas_left).with.offset(-24*WIDTH);
        make.size.mas_equalTo(CGSizeMake(28*WIDTH, 14*HEIGHT));
    }];
    [self.bianjiIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moren);
        make.right.mas_equalTo(self.bianji.mas_left).with.offset(-8*WIDTH);
        make.size.mas_equalTo(CGSizeMake(15*WIDTH, 15*HEIGHT));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.moren.mas_top).with.offset(-15*HEIGHT);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectIMG.mas_left).with.offset(10);
        make.right.mas_equalTo(self.moren.mas_right).with.offset(10);
        make.top.mas_equalTo(self.selectIMG.mas_top).with.offset(-10);
        make.bottom.mas_equalTo(self.selectIMG.mas_bottom).with.offset(10);
    }];
    
    [self.shanchuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shanchuIMG);
        make.height.mas_equalTo(self.shanchuIMG);
        make.right.mas_equalTo(self.shanchu);
        make.centerY.mas_equalTo(self.shanchu);
    }];
    [self.bianjiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bianjiIMG);
        make.height.mas_equalTo(self.bianjiIMG);
        make.right.mas_equalTo(self.bianji);
        make.centerY.mas_equalTo(self.bianjiIMG);
    }];
    [background bringSubviewToFront:self.shanchuBtn];
    [background bringSubviewToFront:self.bianjiBtn];
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = LYColor_A7;
    }
    return _line;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.font = [UIFont systemFontOfSize:14*HEIGHT];
        _name.textColor = LYColor_A3;
    }
    return _name;
}
- (UILabel *)phoneNum{
    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc]init];
        _phoneNum.font = [UIFont systemFontOfSize:14*HEIGHT];
        _phoneNum.textColor = LYColor_A3;
        _phoneNum.textAlignment = NSTextAlignmentRight;
    }
    return _phoneNum;
}
- (UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc]init];
        _address.font = [UIFont systemFontOfSize:13*HEIGHT];
        _address.textColor = LYColor_A3;
        _address.numberOfLines = 0;
    }
    return _address;
}
- (UILabel *)moren{
    if (!_moren) {
        _moren = [[UILabel alloc]init];
        _moren.font = [UIFont systemFontOfSize:14*HEIGHT];
        _moren.textColor = LYColor_A4;
        _moren.text = @"默认地址";
    }
    return _moren;
}
- (UILabel *)bianji{
    if (!_bianji) {
        _bianji = [[UILabel alloc]init];
        _bianji.font = [UIFont systemFontOfSize:12*HEIGHT];
        _bianji.textColor = LYColor_A4;
        _bianji.text = @"编辑";
    }
    return _bianji;
}
- (UILabel *)shanchu{
    if (!_shanchu) {
        _shanchu = [[UILabel alloc]init];
        _shanchu.font = [UIFont systemFontOfSize:12*HEIGHT];
        _shanchu.textColor = LYColor_A4;
        _shanchu.text = @"删除";
    }
    return _shanchu;
}
- (UIImageView *)selectIMG{
    if (!_selectIMG) {
        _selectIMG = [[UIImageView alloc]init];
        _selectIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _selectIMG;
}
- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _selectBtn;
}
- (UIImageView *)bianjiIMG{
    if (!_bianjiIMG) {
        _bianjiIMG = [[UIImageView alloc]init];
        _bianjiIMG.contentMode = UIViewContentModeScaleAspectFit;
        _bianjiIMG.image = [UIImage imageNamed:@"edit.png"];
    }
    return _bianjiIMG;
}
- (UIImageView *)shanchuIMG{
    if (!_shanchuIMG) {
        _shanchuIMG = [[UIImageView alloc]init];
        _shanchuIMG.contentMode = UIViewContentModeScaleAspectFit;
        _shanchuIMG.image = [UIImage imageNamed:@"delete.png"];
    }
    return _shanchuIMG;
}
- (UIButton *)shanchuBtn{
    if (!_shanchuBtn) {
        _shanchuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _shanchuBtn;
}
- (UIButton *)bianjiBtn{
    if (!_bianjiBtn) {
        _bianjiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _bianjiBtn;
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
