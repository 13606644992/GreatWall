//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"
#import "Header.h"
#import "AllLine.h"

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
//        self.clipsToBounds = YES;
        [self setTheViewBounds];
    }
    
    return self;
}

-(void)setTheViewBounds{

    [self addSubview:self.mainImageView];
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@(-31*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(134*WIDTH, 120.5*HEIGHT));
    }];
    
    [self addSubview:self.jiaoLab];
    [self.jiaoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainImageView.mas_bottom).with.offset(18*HEIGHT);
        make.left.equalTo(@(18*WIDTH));
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 16*WIDTH));
    }];

    [self addSubview:self.jiaoQLab];
    [self.jiaoQLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jiaoLab);
        make.right.equalTo(@(-18*WIDTH));
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 16*WIDTH));
    }];
    
    [self addSubview:self.shangLab];
    [self.shangLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jiaoLab.mas_bottom).with.offset(13*HEIGHT);
        make.left.equalTo(@(18*WIDTH));
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 16*WIDTH));
    }];
    
    [self addSubview:self.shangYLab];
    [self.shangYLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shangLab);
        make.right.equalTo(@(-18*WIDTH));
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 16*WIDTH));
    }];

    [self addSubview:self.jiSunLab];
    [self.jiSunLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shangLab);
        make.top.mas_equalTo(self.shangLab.mas_bottom).with.offset(24*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 12*HEIGHT));
    }];
    
    [self addSubview:self.jiBLab];
    [self.jiBLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.jiSunLab);
        make.size.mas_equalTo(CGSizeMake(61*WIDTH, 17*HEIGHT));
    }];
    AllLine *line1 = [[AllLine alloc] initWithFrame:CGRectMake(5, 0, ScreenWindowWidth-25, 4)];
    line1.backgroundColor = [UIColor whiteColor];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(5*HEIGHT));
        make.right.equalTo(@(-18*WIDTH));
        make.top.mas_equalTo(self.jiSunLab.mas_bottom).with.offset(8*HEIGHT);
        make.height.equalTo(@(4*HEIGHT));
    }];
    
    
    [self addSubview:self.sanLan];
    [self.sanLan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(line1.mas_bottom).with.offset(8*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 12*HEIGHT));
    }];
    [self addSubview:self.sanBLab];
    [self.sanBLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.sanLan);
        make.size.mas_equalTo(CGSizeMake(61*WIDTH, 17*HEIGHT));
    }];
    [self addSubview:self.sanCountLan];
    [self.sanCountLan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sanLan.mas_right).with.offset(18*WIDTH);
        make.right.mas_equalTo(self.sanBLab.mas_left).with.offset(-18*WIDTH);
        make.centerY.equalTo(self.sanLan);
        make.height.equalTo(@(12*HEIGHT));
    }];
    AllLine *line2 = [[AllLine alloc] initWithFrame:CGRectMake(5, 0, ScreenWindowWidth-25, 4)];
    line2.backgroundColor = [UIColor whiteColor];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(5*HEIGHT));
        make.right.equalTo(@(-18*WIDTH));
        make.top.mas_equalTo(self.sanLan.mas_bottom).with.offset(8*HEIGHT);
        make.height.equalTo(@(4*HEIGHT));
    }];

    
    [self addSubview:self.siLab];
    [self.siLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(line2.mas_bottom).with.offset(8*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 12*HEIGHT));
    }];
    [self addSubview:self.siBLab];
    [self.siBLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.siLab);
        make.size.mas_equalTo(CGSizeMake(61*WIDTH, 17*HEIGHT));
    }];
    [self addSubview:self.siCountLab];
    [self.siCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sanLan.mas_right).with.offset(18*WIDTH);
        make.right.mas_equalTo(self.sanBLab.mas_left).with.offset(-18*WIDTH);
        make.centerY.equalTo(self.siLab);
        make.height.equalTo(@(12*HEIGHT));
    }];
    AllLine *line3 = [[AllLine alloc] initWithFrame:CGRectMake(5, 0, ScreenWindowWidth-25, 4)];
    line3.backgroundColor = [UIColor whiteColor];
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(5*HEIGHT));
        make.right.equalTo(@(-18*WIDTH));
        make.top.mas_equalTo(self.siLab.mas_bottom).with.offset(8*HEIGHT);
        make.height.equalTo(@(4*HEIGHT));
    }];
    
    
    [self addSubview:self.chengLan];
    [self.chengLan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(line3.mas_bottom).with.offset(8*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 12*HEIGHT));
    }];
    [self addSubview:self.chengBLab];
    [self.chengBLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.chengLan);
        make.size.mas_equalTo(CGSizeMake(61*WIDTH, 17*HEIGHT));
    }];
    [self addSubview:self.chengCountBLab];
    [self.chengCountBLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chengLan.mas_right).with.offset(18*WIDTH);
        make.right.mas_equalTo(self.chengBLab.mas_left).with.offset(-18*WIDTH);
        make.centerY.equalTo(self.chengLan);
        make.height.equalTo(@(12*HEIGHT));
    }];
    AllLine *line4 = [[AllLine alloc] initWithFrame:CGRectMake(5, 0, ScreenWindowWidth-25, 4)];
    line4.backgroundColor = [UIColor whiteColor];
    [self addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(5*HEIGHT));
        make.right.equalTo(@(-18*WIDTH));
        make.top.mas_equalTo(self.chengLan.mas_bottom).with.offset(8*HEIGHT);
        make.height.equalTo(@(4*HEIGHT));
    }];
    
    
    [self addSubview:self.daoLan];
    [self.daoLan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(18*WIDTH));
        make.top.mas_equalTo(line4.mas_bottom).with.offset(8*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 12*HEIGHT));
    }];
    [self addSubview:self.daoBLab];
    [self.daoBLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-18*WIDTH));
        make.centerY.equalTo(self.daoLan);
        make.size.mas_equalTo(CGSizeMake(61*WIDTH, 17*HEIGHT));
    }];
    
    AllLine *line5 = [[AllLine alloc] initWithFrame:CGRectMake(5, 0, ScreenWindowWidth-25, 4)];
    line5.backgroundColor = [UIColor whiteColor];
    [self addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(5*HEIGHT));
        make.right.equalTo(@(-18*WIDTH));
        make.top.mas_equalTo(self.daoLan.mas_bottom).with.offset(8*HEIGHT);
        make.height.equalTo(@(4*HEIGHT));
    }];

    [self addSubview:self.zongAmount];
    [self.zongAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(line5.mas_bottom).with.offset(21*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(ScreenWindowWidth-36*WIDTH, 21*HEIGHT));
    }];
    
    [self addSubview:self.changType];
    [self.changType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(self.zongAmount.mas_bottom).with.offset(3*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 24*HEIGHT));
    }];
    
    [self addSubview:self.coverView];

}
-(void)changeClick:(UIButton *)sender{
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"changeType" object:nil userInfo:nil]];
    
    NSLog(@"-----------");
}
#pragma mark   ----------Controller---------
- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rexiaokuan"]];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}
- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = LYColor_A1;
        _coverView.userInteractionEnabled = YES;
    }
    return _coverView;
}

-(UILabel *)jiaoLab{
    if (!_jiaoLab) {
        _jiaoLab = [[UILabel alloc] init];
        _jiaoLab.text = @"交强险";
        _jiaoLab.textColor = LYColor_A1;
        _jiaoLab.font = [UIFont systemFontOfSize:16*WIDTH];
    }
    return _jiaoLab;
}
-(UILabel *)jiaoQLab{
    if (!_jiaoQLab) {
        _jiaoQLab = [[UILabel alloc] init];
        _jiaoQLab.text = @"投保";
        _jiaoQLab.textColor = LYColor_A4;
        _jiaoQLab.textAlignment = NSTextAlignmentRight;
        _jiaoQLab.font = [UIFont systemFontOfSize:12*WIDTH];
    }
    return _jiaoQLab;
}
-(UILabel *)shangLab{
    if (!_shangLab) {
        _shangLab = [[UILabel alloc] init];
        _shangLab.text = @"商业险";
        _shangLab.textColor = LYColor_A1;
        _shangLab.font = [UIFont systemFontOfSize:16*WIDTH];
    }
    return _shangLab;
}
-(UILabel *)shangYLab{
    if (!_shangYLab) {
        _shangYLab = [[UILabel alloc] init];
        _shangYLab.text = @"投保";
        _shangYLab.textColor = LYColor_A4;
        _shangYLab.font = [UIFont systemFontOfSize:12*WIDTH];
        _shangYLab.textAlignment = NSTextAlignmentRight;

    }
    return _shangYLab;
}
-(UILabel *)jiSunLab{
    if (!_jiSunLab) {
        _jiSunLab = [[UILabel alloc] init];
        _jiSunLab.text = @"机动车损失险";
        _jiSunLab.textColor = LYColor_A4;
        _jiSunLab.font = [UIFont systemFontOfSize:12*WIDTH];
    }
    return _jiSunLab;
}

-(UILabel *)jiBLab{
    if (!_jiBLab) {
        _jiBLab = [[UILabel alloc] init];
        _jiBLab.text = @"不计免赔";
        _jiBLab.textAlignment = NSTextAlignmentCenter;
        _jiBLab.textColor = LYColor_A1;
        _jiBLab.backgroundColor = UIColorRGBA(228, 248, 240, 1);
        _jiBLab.layer.cornerRadius = 2.0f;
        _jiBLab.clipsToBounds = YES;
        _jiBLab.font = [UIFont systemFontOfSize:12*WIDTH];

    }
    return _jiBLab;
}
-(UILabel *)sanLan{
    if (!_sanLan) {
        _sanLan = [[UILabel alloc] init];
        _sanLan.text = @"第三者责任险";
        _sanLan.textColor = LYColor_A4;
        _sanLan.font = [UIFont systemFontOfSize:12*WIDTH];
    }
    return _sanLan;
}
-(UILabel *)sanCountLan{
    if (!_sanCountLan) {
        _sanCountLan = [[UILabel alloc] init];
        _sanCountLan.text = @"150万";
        _sanCountLan.textColor = LYColor_A1;
        _sanCountLan.font = [UIFont systemFontOfSize:12*WIDTH];
        _sanCountLan.textAlignment = NSTextAlignmentRight;
    }
    return _sanCountLan;

}
-(UILabel *)sanBLab{
    if (!_sanBLab) {
        _sanBLab = [[UILabel alloc] init];
        _sanBLab.text = @"不计免赔";
        _sanBLab.textAlignment = NSTextAlignmentCenter;
        _sanBLab.textColor = LYColor_A1;
        _sanBLab.backgroundColor = UIColorRGBA(228, 248, 240, 1);
        _sanBLab.layer.cornerRadius = 2.0f;
        _sanBLab.clipsToBounds = YES;
        _sanBLab.font = [UIFont systemFontOfSize:12*WIDTH];

    }
    return _sanBLab;
}
-(UILabel *)siLab{
    if (!_siLab) {
        _siLab = [[UILabel alloc] init];
        _siLab.text = @"司机责任险";
        _siLab.textColor = LYColor_A4;
        _siLab.font = [UIFont systemFontOfSize:12*WIDTH];
    }
    return _siLab;
}
-(UILabel *)siCountLab{
    if (!_siCountLab) {
        _siCountLab = [[UILabel alloc] init];
        _siCountLab.text = @"2万";
        _siCountLab.textColor = LYColor_A1;
        _siCountLab.font = [UIFont systemFontOfSize:12*WIDTH];
        _siCountLab.textAlignment = NSTextAlignmentRight;

    }
    return _siCountLab;
    
}

-(UILabel *)siBLab{
    if (!_siBLab) {
        _siBLab = [[UILabel alloc] init];
        _siBLab.text = @"不计免赔";
        _siBLab.textAlignment = NSTextAlignmentCenter;
        _siBLab.textColor = LYColor_A1;
        _siBLab.backgroundColor = UIColorRGBA(228, 248, 240, 1);
        _siBLab.layer.cornerRadius = 2.0f;
        _siBLab.clipsToBounds = YES;
        _siBLab.font = [UIFont systemFontOfSize:12*WIDTH];

    }
    return _siBLab;
}
-(UILabel *)chengLan{
    if (!_chengLan) {
        _chengLan = [[UILabel alloc] init];
        _chengLan.text = @"乘客责任险";
        _chengLan.textColor = LYColor_A4;
        _chengLan.font = [UIFont systemFontOfSize:12*WIDTH];
    }
    return _chengLan;
}
-(UILabel *)chengCountBLab{
    if (!_chengCountBLab) {
        _chengCountBLab = [[UILabel alloc] init];
        _chengCountBLab.text = @"2万";
        _chengCountBLab.textColor = LYColor_A1;
        _chengCountBLab.font = [UIFont systemFontOfSize:12*WIDTH];
        _chengCountBLab.textAlignment = NSTextAlignmentRight;

    }
    return _chengCountBLab;
    
}
-(UILabel *)chengBLab{
    if (!_chengBLab) {
        _chengBLab = [[UILabel alloc] init];
        _chengBLab.text = @"不计免赔";
        _chengBLab.textAlignment = NSTextAlignmentCenter;
        _chengBLab.textColor = LYColor_A1;
        _chengBLab.backgroundColor = UIColorRGBA(228, 248, 240, 1);
        _chengBLab.layer.cornerRadius = 2.0f;
        _chengBLab.clipsToBounds = YES;
        _chengBLab.font = [UIFont systemFontOfSize:12*WIDTH];

    }
    return _chengBLab;
}
-(UILabel *)daoLan{
    if (!_daoLan) {
        _daoLan = [[UILabel alloc] init];
        _daoLan.text = @"盗抢险";
        _daoLan.textColor = LYColor_A4;
        _daoLan.font = [UIFont systemFontOfSize:12*WIDTH];
    }
    return _daoLan;
}
-(UILabel *)daoBLab{
    if (!_daoBLab) {
        _daoBLab = [[UILabel alloc] init];
        _daoBLab.text = @"不计免赔";
        _daoBLab.textAlignment = NSTextAlignmentCenter;
        _daoBLab.textColor = LYColor_A1;
        _daoBLab.backgroundColor = UIColorRGBA(228, 248, 240, 1);
        _daoBLab.layer.cornerRadius = 2.0f;
        _daoBLab.clipsToBounds = YES;
        _daoBLab.font = [UIFont systemFontOfSize:12*WIDTH];

    }
    return _daoBLab;
}
-(UILabel *)zongAmount{
    if (!_zongAmount) {
        _zongAmount = [[UILabel alloc] init];
        _zongAmount.textColor = LYColor_A2;
        _zongAmount.text = @"¥6000000";
        _zongAmount.textAlignment = NSTextAlignmentCenter;
        _zongAmount.font = [UIFont systemFontOfSize:21*WIDTH];
    }
    return _zongAmount;
}
-(UIButton *)changType{
    if (!_changType) {
        _changType = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changType setTitle:@"修改投保方案>" forState:UIControlStateNormal];
        [_changType setTitleColor:LYColor_A1 forState:UIControlStateNormal];
        _changType.titleLabel.font = [UIFont systemFontOfSize:12*WIDTH];
//        _changType.userInteractionEnabled = YES;
        [_changType addTarget:self  action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changType;
}




@end
