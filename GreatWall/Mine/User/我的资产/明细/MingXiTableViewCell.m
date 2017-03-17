//
//  MingXiTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/3/1.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "MingXiTableViewCell.h"
#import "Header.h"
#import "MingXiModel.h"

@implementation MingXiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.moneyLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(17*HEIGHT);
        make.height.mas_equalTo(15*HEIGHT);
    }];
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];//自适应宽度
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10*HEIGHT);
        make.bottom.mas_equalTo(-16*HEIGHT);
        make.width.mas_equalTo(180 *WIDTH);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18*WIDTH);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(21*HEIGHT);
    }];
    [self.moneyLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];//自适应宽度
}

- (void)setMingXiModel:(MingXiModel *)mingXiModel{
    self.titleLabel.text = mingXiModel.tradeDesc;
    NSString *str = [NSString stringWithFormat:@"%@",mingXiModel.logTime];
    NSTimeInterval time = [str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dataFormatter stringFromDate:detaildate];
    self.timeLabel.text = dateStr;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",mingXiModel.tradeAmount];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16*HEIGHT];
        _titleLabel.textColor = LYColor_A3;
//        _titleLabel.text = @"推广费收入（个人借款保证保险）";
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = LYColor_A4;
        _timeLabel.font = [UIFont systemFontOfSize:12*HEIGHT];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
//        _timeLabel.text = @"2017-03-01";
    }
    return _timeLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
         _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = [UIFont systemFontOfSize:20*HEIGHT];
//        _moneyLabel.text = @"+1111.00";
    }
    return _moneyLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
