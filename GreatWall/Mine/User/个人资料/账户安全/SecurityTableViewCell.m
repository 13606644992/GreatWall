//
//  SecurityTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/17.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "SecurityTableViewCell.h"
#import "Header.h"
@implementation SecurityTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubview];
    }
    return self;
}
- (void)creatSubview{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 17*HEIGHT));
    }];
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(7*HEIGHT);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(300*WIDTH, 12*HEIGHT));
    }];
    UIImageView *jiantouIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    jiantouIMG.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:jiantouIMG];
    [jiantouIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(5.5*WIDTH, 9.5*HEIGHT));
    }];
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:16*HEIGHT];
        _titleLab.textColor = LYColor_A3;
    }
    return _titleLab;
}
- (UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.font = [UIFont systemFontOfSize:12*HEIGHT];
        _contentLab.textColor = LYColor_A4;
    }
    return _contentLab;
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
