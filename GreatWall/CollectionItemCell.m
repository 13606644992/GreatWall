//
//  CollectionItemCell.m
//  GreatWall
//
//  Created by 李阳 on 2017/2/23.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CollectionItemCell.h"

@implementation CollectionItemCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.lineLab];
        [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-110*WIDTH));
            make.top.bottom.equalTo(self.contentView);
            make.width.equalTo(@(1));
        }];
        [self.contentView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.lineLab);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@(12*HEIGHT));
        }];
        [self.contentView addSubview:self.detailLab];
        [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.left.equalTo(self.lineLab);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@(12*HEIGHT));
        }];
        [self.contentView addSubview:self.bottomlineLab];
        [self.bottomlineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@(1));
        }];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTrade:(PayTrade *)trade
{
    
}
#pragma mark ---------Controller-------------
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = LYColor_A4;
        _titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _titleLab.text = @"保险责任";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
-(UILabel *)detailLab
{  
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] init];
        _detailLab.textColor = LYColor_A4;
        _detailLab.font = [UIFont systemFontOfSize:14*WIDTH];
        _detailLab.text = @"保额";
        _detailLab.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLab;
}
-(UILabel *)lineLab
{
    if (!_lineLab) {
        _lineLab = [[UILabel alloc] init];
        _lineLab.backgroundColor = LYColor_A7;
    }
    return _lineLab;
}
-(UILabel *)bottomlineLab
{
    if (!_bottomlineLab) {
        _bottomlineLab = [[UILabel alloc] init];
        _bottomlineLab.backgroundColor = LYColor_A7;
    }
    return _bottomlineLab;
}
@end
