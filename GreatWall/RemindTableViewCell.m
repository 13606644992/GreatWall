//
//  RemindTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/12.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "RemindTableViewCell.h"
#import "Header.h"
@implementation RemindTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubview];
    }
    return self;
}
- (void)creatSubview{
    self.contentView.backgroundColor = LYColor_A7;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *background = [[UIView alloc]initWithFrame:CGRectMake(18*WIDTH, 0, 339*WIDTH, 81*HEIGHT)];
    background.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:background];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:background.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = background.bounds;
    maskLayer.path = maskPath.CGPath;
    background.layer.mask = maskLayer;

    //分类
    [background addSubview:self.kind];
    [self.kind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(30*WIDTH);
    }];
    NSString *labelText = self.kind.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.kind.attributedText = attributedString;
    self.kind.textAlignment = NSTextAlignmentCenter;
    //标题
    [background addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21*HEIGHT);
        make.width.mas_equalTo(200*WIDTH);
         make.left.mas_equalTo(self.kind.mas_right).with.offset(24*WIDTH);
        make.height.mas_equalTo(17*HEIGHT);
    }];
    self.titleLabel.text = @"马云的生日";
    //日期
    [background addSubview:self.date];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(11*HEIGHT);
        make.width.mas_equalTo(200*WIDTH);
        make.left.mas_equalTo(self.kind.mas_right).with.offset(24*WIDTH);
        make.height.mas_equalTo(12*HEIGHT);
    }];
    self.date.text = @"2016-09-06";
    //剩余时间
    [background addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30*WIDTH);
        make.width.mas_equalTo(60*WIDTH);
        make.height.mas_equalTo(25*HEIGHT);
        make.centerY.mas_equalTo(background);
    }];
    self.time.text = @"3天";
}
- (UILabel *)kind{
    if (!_kind) {
        _kind = [[UILabel alloc]init];
        _kind.numberOfLines = 0;
        _kind.backgroundColor = UIColorRGBA(255, 141, 138, 1);
        _kind.clipsToBounds = YES;
        _kind.text = @"生日";
        _kind.font = [UIFont systemFontOfSize:16*HEIGHT];
        _kind.textColor = [UIColor whiteColor];
    }
    return _kind;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16*HEIGHT];
        _titleLabel.textColor = LYColor_A3;
    }
    return _titleLabel;
}
- (UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.font = [UIFont systemFontOfSize:11*HEIGHT];
        _date.textColor = LYColor_A4;
    }
    return _date;
}
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.font = [UIFont systemFontOfSize:20*HEIGHT];
        _time.textColor = UIColorRGBA(255, 93, 89, 1);
        _time.textAlignment = NSTextAlignmentRight;
    }
    return _time;
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
