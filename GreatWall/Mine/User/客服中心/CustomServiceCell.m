//
//  CustomServiceCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CustomServiceCell.h"
#import "Header.h"
@implementation CustomServiceCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubview];
    }
    return self;
}
- (void)creatSubview{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.question];
    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(18*WIDTH);
        make.size.mas_equalTo(CGSizeMake(300*WIDTH, 20*HEIGHT));
    }];
}
- (UILabel *)question{
    if (!_question) {
        _question = [[UILabel alloc]init];
        _question.font = [UIFont systemFontOfSize:14*HEIGHT];
        _question.textColor = LYColor_A3;
    }
    return _question;
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
