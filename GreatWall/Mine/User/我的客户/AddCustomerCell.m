//
//  AddCustomerCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/12.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "AddCustomerCell.h"
#import "Header.h"
@implementation AddCustomerCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubview];
    }
    return self;
}
- (void)creatSubview{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.content];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 15*HEIGHT));
    }];
    [self.contentView addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(130*WIDTH);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 35*HEIGHT));
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = LYColor_A3;
        _titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
    }
    return _titleLabel;
}
- (UITextField *)content{
    if (!_content) {
        _content = [[UITextField alloc]init];
        _content.textColor = LYColor_A4;
        _content.font = [UIFont systemFontOfSize:13*HEIGHT];
    }
    return _content;
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
