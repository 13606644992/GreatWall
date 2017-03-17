//
//  LYShareType.m
//  GreatWall
//
//  Created by 李阳 on 2017/3/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "LYShareType.h"
#import "Header.h"
#import "UIView+Frame.h"

@interface LYShareType ()

@property (nonatomic, strong) UIView       * bgView;
@property (nonatomic, strong) UIView       * typeView;


@end

@implementation LYShareType


static id _instace;

+ (instancetype)shareShareType{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{// 只创建一次
        _instace = [[self alloc] init];
    });
    return _instace;
}
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{// 只初始化一次
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}
- (void)LYShareTypeShowMode{
    if (!self.typeView) {
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight)];
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.alpha = 0.7;
        
        
        self.typeView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWindowHeight, ScreenWindowWidth, 250*HEIGHT)];
        self.typeView.userInteractionEnabled = YES;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.alpha = 0.9;
        [self.typeView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.typeView);
        }];
   

//  ============================= 添加内容=======================================================================
    
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = @"分享";
        titleLab.textColor = LYColor_A3;
        titleLab.font = [UIFont systemFontOfSize:14*WIDTH];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [self.typeView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.typeView);
            make.top.equalTo(@(18*HEIGHT));
            make.height.equalTo(@(14*HEIGHT));
        }];
        UILabel *contentLab = [[UILabel alloc] init];
        contentLab.text = @"分享后推广费不可见";
        contentLab.textColor = LYColor_A4;
        contentLab.font = [UIFont systemFontOfSize:11*WIDTH];
        contentLab.textAlignment = NSTextAlignmentCenter;
        [self.typeView addSubview:contentLab];
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.typeView);
            make.top.mas_equalTo(titleLab.mas_bottom).with.offset(11*HEIGHT);
            make.height.equalTo(@(11*HEIGHT));
        }];
        if ([IS_Bclient integerValue] == 1) {
            contentLab.hidden = NO;
        }else{
            contentLab.hidden = YES;
        }
        
        UIButton *weiYou = [UIButton buttonWithType:UIButtonTypeCustom];
        [weiYou setImage:[UIImage imageNamed:@"weixinlogo"] forState:UIControlStateNormal];
        weiYou.tag = 1;
        [weiYou addTarget:self action:@selector(weiTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.typeView addSubview:weiYou];
        [weiYou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(80*WIDTH));
            make.top.mas_equalTo(titleLab.mas_bottom).with.offset(65*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(49*WIDTH, 49*WIDTH));
        }];
        
        UILabel *weiYouLab = [[UILabel alloc] init];
        weiYouLab.textAlignment = NSTextAlignmentCenter;
        weiYouLab.text = @"微信好友";
        weiYouLab.textColor = LYColor_A4;
        weiYouLab.font = [UIFont systemFontOfSize:12*WIDTH];
        [self.typeView addSubview:weiYouLab];
        [weiYouLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weiYou);
            make.top.mas_equalTo(weiYou.mas_bottom).with.offset(13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(70*WIDTH, 12*HEIGHT));
        }];
        
        
        UIButton *weiQuan = [UIButton buttonWithType:UIButtonTypeCustom];
        [weiQuan setImage:[UIImage imageNamed:@"pengyouquan"] forState:UIControlStateNormal];
        weiQuan.tag = 2;
        [weiQuan addTarget:self action:@selector(weiTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.typeView addSubview:weiQuan];
        [weiQuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-80*WIDTH));
            make.top.mas_equalTo(titleLab.mas_bottom).with.offset(65*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(49*WIDTH, 49*WIDTH));
        }];
        
        UILabel *weiQuanLab = [[UILabel alloc] init];
        weiQuanLab.textAlignment = NSTextAlignmentCenter;
        weiQuanLab.text = @"微信朋友圈";
        weiQuanLab.textColor = LYColor_A4;
        weiQuanLab.font = [UIFont systemFontOfSize:12*WIDTH];
        [self.typeView addSubview:weiQuanLab];
        [weiQuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weiQuan);
            make.top.mas_equalTo(weiQuan.mas_bottom).with.offset(13*HEIGHT);
            make.size.mas_equalTo(CGSizeMake(70*WIDTH, 12*HEIGHT));
        }];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:LYColor_A3 forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18*WIDTH];
        [self.typeView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.typeView);
            make.height.equalTo(@(49*HEIGHT));
        }];
        
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.bgView];
        [window addSubview:self.typeView];
        [UIView animateWithDuration:0.3 animations:^{
            self.typeView.y = ScreenWindowHeight - 250*HEIGHT;
        }];
    }
}

- (void)LYShareTypeBackSelectBlock:(ShareSelectBlock)block{
     self.block = block;
}
-(void)cancelClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.typeView.y = ScreenWindowHeight;
    }completion:^(BOOL finished) {
        [self.typeView removeFromSuperview];
        self.typeView = nil;
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
}
-(void)weiTypeClick:(UIButton *)sender{
    
    self.block([NSString stringWithFormat:@"%ld",sender.tag]);
    
    [self cancelClick];
}

@end
