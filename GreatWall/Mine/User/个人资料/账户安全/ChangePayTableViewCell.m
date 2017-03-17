//
//  ChangePayTableViewCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/27.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ChangePayTableViewCell.h"
#import "Header.h"

@implementation ChangePayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        self.titleLabel.textColor = LYColor_A3;
        [self.contentView addSubview:self.titleLabel];
        
        self.imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou.png"]];
        [self.contentView addSubview:self.imageV];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18*WIDTH);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(200*WIDTH, 15*HEIGHT));
        }];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18*WIDTH);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(5.5*WIDTH, 9.5*HEIGHT));
        }];
        
    }
    return self;
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
