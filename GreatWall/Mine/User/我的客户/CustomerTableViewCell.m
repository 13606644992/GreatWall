//
//  CustomerTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/3/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CustomerTableViewCell.h"
#import "Customer.h"
#import "Header.h"

@implementation CustomerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(41*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 14*HEIGHT));
    }];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(41*WIDTH, 56*HEIGHT - 1, ScreenWindowWidth - 70*WIDTH, 1)];
    label.backgroundColor = LYColor_A6;
    [self.contentView addSubview:label];
}


- (void)setCustomerModel:(Customer *)customerModel{
//    self.nameLabel.text = 
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        _nameLabel.textColor = LYColor_A3;
    }
    return _nameLabel;
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
