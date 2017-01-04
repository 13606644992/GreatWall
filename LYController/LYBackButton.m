//
//  LYBackButton.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "LYBackButton.h"

@implementation LYBackButton

+(LYBackButton *)setBackBtn
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 25, 80, 35);
    [backBtn setImage:[UIImage imageNamed:@"iccleft.png"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 0, 7,60);
//    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    backBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(5,-20, 5,10);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    return (LYBackButton *)backBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
