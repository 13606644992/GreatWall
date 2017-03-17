//
//  CheXianDetailCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/7.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CheXianDetailCell.h"
#import "Header.h"
@implementation CheXianDetailCell

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
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 15*HEIGHT));
    }];
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 15*HEIGHT));
    }];
    [self.contentView addSubview:self.jiantouIMG];
    [self.jiantouIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentLab);
        make.top.mas_equalTo(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(12.5*WIDTH, 7.5*HEIGHT));
    }];
    [self.contentView addSubview:self.background];
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(20*HEIGHT);
        make.left.mas_equalTo(self.titleLab);
        make.right.mas_equalTo(self.contentLab);
        make.bottom.mas_equalTo(-20*HEIGHT);
    }];
    [self.background addSubview:self.backCheLiangLabel];
    [self.background addSubview:self.backCheLiangDetailLabel];
    [self.background addSubview:self.backDiSanZheLabel];
    [self.background addSubview:self.backDiSanZheDetailLabel];
    [self.background addSubview:self.backSiJiLabel];
    [self.background addSubview:self.backSiJiDetailLabel];
    [self.background addSubview:self.backChengKeLabel];
    [self.background addSubview:self.backChengKeDetailLabel];
    [self.background addSubview:self.backDaoQiangLabel];
    [self.background addSubview:self.backDaoQiangDetailLabel];
    
    [self.backCheLiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26*WIDTH);
        make.top.mas_equalTo(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 14*HEIGHT));
    }];
    [self.backCheLiangDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26*WIDTH);
        make.top.mas_equalTo(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 14*HEIGHT));
    }];
    [self.backDiSanZheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26*WIDTH);
        make.top.mas_equalTo(self.backCheLiangLabel.mas_bottom).offset(27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 14*HEIGHT));
    }];
    [self.backDiSanZheDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26*WIDTH);
        make.top.mas_equalTo(self.backDiSanZheLabel);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 14*HEIGHT));
    }];
    [self.backSiJiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26*WIDTH);
        make.top.mas_equalTo(self.backDiSanZheLabel.mas_bottom).offset(27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 14*HEIGHT));
    }];
    [self.backSiJiDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26*WIDTH);
        make.top.mas_equalTo(self.backSiJiLabel);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 14*HEIGHT));
    }];
    [self.backChengKeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26*WIDTH);
        make.top.mas_equalTo(self.backSiJiLabel.mas_bottom).offset(27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 14*HEIGHT));
    }];
    [self.backChengKeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26*WIDTH);
        make.top.mas_equalTo(self.backChengKeLabel);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 14*HEIGHT));
    }];
    [self.backDaoQiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26*WIDTH);
        make.top.mas_equalTo(self.backChengKeLabel.mas_bottom).offset(27.5*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 14*HEIGHT));
    }];
    [self.backDaoQiangDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26*WIDTH);
        make.top.mas_equalTo(self.backDaoQiangLabel);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 14*HEIGHT));
    }];
    
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:14.0f*HEIGHT];
        _titleLab.textColor = LYColor_A4;
    }
    return _titleLab;
}
- (UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.font = [UIFont systemFontOfSize:14.0f*HEIGHT];
        _contentLab.textColor = LYColor_A4;
        _contentLab.textAlignment = NSTextAlignmentRight;
    }
    return _contentLab;
}
- (UIImageView *)jiantouIMG{
    if (!_jiantouIMG) {
        _jiantouIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"baodan-jiantou-shang.png"]];
        _jiantouIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _jiantouIMG;
}
- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _selectBtn;
}
- (UIView *)background{
    if (!_background) {
        _background = [[UIView alloc]init];
        _background.backgroundColor = LYColor_A7;
    }
    return _background;
}
- (UILabel *)backCheLiangLabel{
    if (!_backCheLiangLabel) {
        _backCheLiangLabel = [[UILabel alloc]init];
        _backCheLiangLabel.textColor = LYColor_A4;
        _backCheLiangLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _backCheLiangLabel;
}
- (UILabel *)backCheLiangDetailLabel{
    if (!_backCheLiangDetailLabel) {
        _backCheLiangDetailLabel = [[UILabel alloc]init];
        _backCheLiangDetailLabel.textColor = LYColor_A4;
        _backCheLiangDetailLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        _backCheLiangDetailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _backCheLiangDetailLabel;
}
- (UILabel *)backDiSanZheLabel{
    if (!_backDiSanZheLabel) {
        _backDiSanZheLabel = [[UILabel alloc]init];
        _backDiSanZheLabel.textColor = LYColor_A4;
        _backDiSanZheLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _backDiSanZheLabel;
}
- (UILabel *)backDiSanZheDetailLabel{
    if (!_backDiSanZheDetailLabel) {
        _backDiSanZheDetailLabel = [[UILabel alloc]init];
        _backDiSanZheDetailLabel.textColor = LYColor_A4;
        _backDiSanZheDetailLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        _backDiSanZheDetailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _backDiSanZheDetailLabel;
}
- (UILabel *)backSiJiLabel{
    if (!_backSiJiLabel) {
        _backSiJiLabel = [[UILabel alloc]init];
        _backSiJiLabel.textColor = LYColor_A4;
        _backSiJiLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _backSiJiLabel;
}
- (UILabel *)backSiJiDetailLabel{
    if (!_backSiJiDetailLabel) {
        _backSiJiDetailLabel = [[UILabel alloc]init];
        _backSiJiDetailLabel.textColor = LYColor_A4;
        _backSiJiDetailLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        _backSiJiDetailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _backSiJiDetailLabel;
}

- (UILabel *)backChengKeLabel{
    if (!_backChengKeLabel) {
        _backChengKeLabel = [[UILabel alloc]init];
        _backChengKeLabel.textColor = LYColor_A4;
        _backChengKeLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _backChengKeLabel;
}
- (UILabel *)backChengKeDetailLabel{
    if (!_backChengKeDetailLabel) {
        _backChengKeDetailLabel = [[UILabel alloc]init];
        _backChengKeDetailLabel.textColor = LYColor_A4;
        _backChengKeDetailLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        _backChengKeDetailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _backChengKeDetailLabel;
}

- (UILabel *)backDaoQiangLabel{
    if (!_backDaoQiangLabel) {
        _backDaoQiangLabel = [[UILabel alloc]init];
        _backDaoQiangLabel.textColor = LYColor_A4;
        _backDaoQiangLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _backDaoQiangLabel;
}
- (UILabel *)backDaoQiangDetailLabel{
    if (!_backDaoQiangDetailLabel) {
        _backDaoQiangDetailLabel = [[UILabel alloc]init];
        _backDaoQiangDetailLabel.textColor = LYColor_A4;
        _backDaoQiangDetailLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        _backDaoQiangDetailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _backDaoQiangDetailLabel;
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
