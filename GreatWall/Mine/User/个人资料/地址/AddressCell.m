//
//  AddressCell.m
//  GreatWall
//
//  Created by GJ on 2017/2/15.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "AddressCell.h"
#import "Header.h"
@implementation AddressCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}
- (void)creatSubView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.area];
    [self.area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25*WIDTH);
        make.top.mas_equalTo(16*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200, 15*HEIGHT));
    }];

}
- (UILabel *)area{
    if (!_area) {
        _area = [[UILabel alloc]init];
        _area.font = [UIFont systemFontOfSize:14*HEIGHT];
        _area.textColor = LYColor_A3;
    }
    return _area;
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
