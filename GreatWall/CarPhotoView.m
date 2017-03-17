//
//  CarPhotoView.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/8.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "CarPhotoView.h"
#import "Header.h"

@implementation CarPhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        
        [self setUI];
    }
    return self;
}
-(void)setUI{
    UIImageView *bgImg = [[UIImageView alloc] init];
    bgImg.backgroundColor = [UIColor blackColor];
    bgImg.alpha = 0.6;
    [self addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"拍摄获取行驶证相关信息";
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:16*WIDTH];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@(75*HEIGHT));
        make.size.mas_equalTo(CGSizeMake(259*WIDTH, 16*HEIGHT));
    }];
    UILabel *desLab = [[UILabel alloc] init];
    desLab.text = @"请对照红线框选择区域进行填写";
    desLab.textColor = [UIColor whiteColor];
    desLab.textAlignment = NSTextAlignmentCenter;
    desLab.font = [UIFont systemFontOfSize:12*WIDTH];
    [self addSubview:desLab];
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(titleLab.mas_bottom).with.offset(13*HEIGHT);
        make.size.mas_equalTo(CGSizeMake(259*WIDTH, 12*HEIGHT));
    }];
    
    UIImageView *titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shili"]];
    [self addSubview:titleImg];
    [titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(desLab.mas_bottom).with.offset(13*HEIGHT);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(280*WIDTH, 197*HEIGHT));
    }];
    
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeBtn setImage:[UIImage imageNamed:@"shanchu(paishetankuang)"] forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:removeBtn];
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleImg.mas_bottom).with.offset(31*HEIGHT);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(27*WIDTH, 27*HEIGHT));
    }];
}
-(void)removeClick{
    [self removeFromSuperview];
}
@end
