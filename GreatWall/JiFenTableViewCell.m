//
//  JiFenTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/1/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "JiFenTableViewCell.h"
#import "Header.h"
@implementation JiFenTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}
- (void)creatSubView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.date];
//    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.jifen];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(18*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(250*WIDTH, 17*HEIGHT));
    }];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.top.mas_equalTo(self.title.mas_bottom).with.offset(8*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 13*HEIGHT));
    }];
//    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.date.mas_right).with.offset(10*WIDTH);
//        make.top.mas_equalTo(self.title.mas_bottom).with.offset(8*HEIGHT);
//        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 13*HEIGHT));
//    }];
    [self.jifen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 33*HEIGHT));
    }];
    
//    self.title.text = @"实名认证成功";
//    self.date.text = @"2016-12-08";
//    self.time.text = @"12:23:59";
//    self.jifen.text = @"+100";
}
- (UILabel *)jifen{
    if (!_jifen) {
        _jifen = [[UILabel alloc]init];
        _jifen.font = [UIFont systemFontOfSize:20*HEIGHT];
        _jifen.textColor = UIColorRGBA(255, 93, 89, 1);
        _jifen.textAlignment = NSTextAlignmentRight;
    }
    return _jifen;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:16*HEIGHT];
        _title.textColor = LYColor_A3;
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}
- (UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.font = [UIFont systemFontOfSize:12*HEIGHT];
        _date.textColor = LYColor_A4;
        _date.textAlignment = NSTextAlignmentLeft;
        
    }
    return _date;
}
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.font = [UIFont systemFontOfSize:12*HEIGHT];
        _time.textColor = LYColor_A4;
        _time.textAlignment = NSTextAlignmentLeft;
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
