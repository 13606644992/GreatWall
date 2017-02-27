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
//    [self.contentView addSubview:self.background];
//    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(20*HEIGHT);
//        make.left.mas_equalTo(self.titleLab);
//        make.right.mas_equalTo(self.contentLab);
//        make.bottom.mas_equalTo(-20*HEIGHT);
//    }];
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
