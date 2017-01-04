//
//  LYTitleLable.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "LYTitleLable.h"
#import "Header.h"

@implementation LYTitleLable

+(LYTitleLable *)setNavagationTitle:(NSString *)title WithColor:(UIColor *)color
{
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleLable.center = CGPointMake(ScreenWindowWidth/2, 40);
    titleLable.text = title;
    titleLable.textColor = color;
    titleLable.font = [UIFont systemFontOfSize:17*HEIGHT];
    titleLable.textAlignment = NSTextAlignmentCenter;
    return (LYTitleLable *)titleLable;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
