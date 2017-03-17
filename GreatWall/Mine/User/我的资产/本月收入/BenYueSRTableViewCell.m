//
//  BenYueSRTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/3/1.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "BenYueSRTableViewCell.h"
#import "Header.h"
#import "BenYueModel.h"

@implementation BenYueSRTableViewCell

- (UIView *)myView{
    if (!_myView) {
        _myView = [[UIView alloc]init];
        _myView.backgroundColor = LYColor_A7;
        _myView.layer.cornerRadius = 20*WIDTH;
        
    }
    return _myView;
}
- (UILabel *)timelabel{
    if (!_timelabel) {
        _timelabel = [[UILabel alloc]init];
        _timelabel.textColor = LYColor_A4;
        _timelabel.font = [UIFont systemFontOfSize:11*HEIGHT];
        _timelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timelabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = LYColor_A3;
        _titleLabel.font = [UIFont systemFontOfSize:16*HEIGHT];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UILabel *)numberlabel{
    if (!_numberlabel) {
        _numberlabel = [[UILabel alloc]init];
        _numberlabel.textColor = LYColor_A4;
        _numberlabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        _numberlabel.textAlignment = NSTextAlignmentLeft;
    }
    return _numberlabel;
}
- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = UIColorRGBA(255, 93, 89, 1);
        _moneyLabel.font = [UIFont systemFontOfSize:20*HEIGHT];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}

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
    
    
    [self.contentView addSubview:self.myView];
    [self.myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(40*WIDTH, 40*HEIGHT));
    }];
    
    [self.myView addSubview:self.timelabel];
    [self.timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-8*HEIGHT);
        make.centerX.mas_equalTo(self.myView);
        make.centerY.mas_equalTo(self.myView);
        make.size.mas_equalTo(CGSizeMake(40*WIDTH, 12*HEIGHT));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17.5*HEIGHT);
        make.left.mas_equalTo(self.myView.mas_right).with.offset(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 16*HEIGHT));
    }];
//    self.titleLabel.text = @"防守打法上帝爱附近";
//    self.numberlabel.text = @"防守打法上帝爱附近";
    
    [self.contentView addSubview:self.numberlabel];
    [self.numberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(5*HEIGHT);
        make.left.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 12*HEIGHT));
    }];
    
    
    [self.contentView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.numberlabel.mas_right);
        make.height.mas_equalTo(20*HEIGHT);
    }];
    
}

- (void)setBenYueModel:(BenYueModel *)benYueModel{
    _benYueModel = benYueModel;
    NSString *yueStr = [benYueModel.tradeTime substringWithRange:NSMakeRange(5, 2)];
    NSString *monthStr = [benYueModel.tradeTime substringWithRange:NSMakeRange(8, 2)];
    self.timelabel.text = [NSString stringWithFormat:@"%@/%@",monthStr,yueStr];
    self.moneyLabel.text = [NSString stringWithFormat:@"+%@", benYueModel.dayTotalAmount];
    self.numberlabel.text = [NSString stringWithFormat:@"保单号：%@",benYueModel.tradeNo];
    self.titleLabel.text = benYueModel.productName;
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
