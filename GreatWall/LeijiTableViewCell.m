//
//  LeijiTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/1/12.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "LeijiTableViewCell.h"
#import "Header.h"
@implementation LeijiTableViewCell


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
    
    
    [self.contentView addSubview:self.date];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(120*WIDTH, 15*HEIGHT));
    }];
    [self.contentView addSubview:self.jiantouIMG];
    [self.jiantouIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.date);
        make.right.mas_equalTo(-18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(8*WIDTH, 10*HEIGHT));
    }];
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.date);
        make.right.mas_equalTo(self.jiantouIMG.mas_left).with.offset(-9*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 15*HEIGHT));
    }];
    
    
}



- (UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.textColor = LYColor_A3;
        _date.font = [UIFont systemFontOfSize:14*HEIGHT];
        _date.textAlignment = NSTextAlignmentLeft;
    }
    return _date;
}
- (UILabel *)money{
    if (!_money) {
        _money = [[UILabel alloc]init];
        _money.textColor = LYColor_A3;
        _money.font = [UIFont systemFontOfSize:14*HEIGHT];
        _money.textAlignment = NSTextAlignmentRight;
    }
    return _money;
}
- (UIImageView *)jiantouIMG{
    if (!_jiantouIMG) {
        _jiantouIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
        _jiantouIMG.backgroundColor = [UIColor whiteColor];
        _jiantouIMG.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _jiantouIMG;
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
