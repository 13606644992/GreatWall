//
//  JieSuanTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/1/11.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "JieSuanTableViewCell.h"
#import "Header.h"
#import "JieSuanModel.h"
@implementation JieSuanTableViewCell

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
    
    [self.myView addSubview:self.date];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8*HEIGHT);
        make.centerX.mas_equalTo(self.myView);
        make.size.mas_equalTo(CGSizeMake(30*WIDTH, 10*HEIGHT));
    }];
    [self.myView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-8*HEIGHT);
        make.centerX.mas_equalTo(self.myView);
        make.size.mas_equalTo(CGSizeMake(40*WIDTH, 10*HEIGHT));
    }];

    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17.5*HEIGHT);
        make.left.mas_equalTo(self.myView.mas_right).with.offset(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 16*HEIGHT));
    }];

    
    [self.contentView addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).with.offset(5*HEIGHT);
        make.left.mas_equalTo(self.title);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 12*HEIGHT));
    }];
//    self.number.text = @"保单号：HBX8765789043257897";
    
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.number.mas_right);
        make.height.mas_equalTo(20*HEIGHT);
    }];
//    self.money.text = @"+36.68";
}

- (void)setJieSuanModel:(JieSuanModel *)jieSuanModel{
    _jieSuanModel = jieSuanModel;
//    self.date.text = [jieSuanModel.tradeTime substringWithRange:NSMakeRange(0, <#NSUInteger len#>)]
    self.title.text = jieSuanModel.productName;
    self.number.text = [NSString stringWithFormat:@"保单号：%@", jieSuanModel.policyNo];
    self.money.text = [NSString stringWithFormat:@"+%@", jieSuanModel.settSum];
}
- (UIView *)myView{
    if (!_myView) {
        _myView = [[UIView alloc]init];
        _myView.backgroundColor = LYColor_A7;
        _myView.layer.cornerRadius = 20*WIDTH;
        
    }
    return _myView;
}
- (UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.textColor = LYColor_A4;
        _date.font = [UIFont systemFontOfSize:11*HEIGHT];
        _date.textAlignment = NSTextAlignmentCenter;
    }
    return _date;
}
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.textColor = LYColor_A4;
        _time.font = [UIFont systemFontOfSize:11*HEIGHT];
        _time.textAlignment = NSTextAlignmentCenter;
    }
    return _time;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = LYColor_A3;
        _title.font = [UIFont systemFontOfSize:16*HEIGHT];
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}
- (UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc]init];
        _number.textColor = LYColor_A4;
        _number.font = [UIFont systemFontOfSize:12*HEIGHT];
        _number.textAlignment = NSTextAlignmentLeft;
    }
    return _number;
}
- (UILabel *)money{
    if (!_money) {
        _money = [[UILabel alloc]init];
        _money.textColor = UIColorRGBA(255, 93, 89, 1);
        _money.font = [UIFont systemFontOfSize:20*HEIGHT];
        _money.textAlignment = NSTextAlignmentRight;
    }
    return _money;
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
