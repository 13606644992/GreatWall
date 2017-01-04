//
//  BezierPathLine.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/28.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "BezierPathLine.h"
#import "Header.h"

@implementation BezierPathLine


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat height = 132*HEIGHT;
    CGFloat hoX = ScreenWindowWidth-13*WEIGHT;
    UIColor *color = LYColor_A6;
    [color set];  //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(13*WEIGHT, 0)];
    // Draw the lines
    [aPath addLineToPoint:CGPointMake(13*WEIGHT, height-3)];
    [aPath addCurveToPoint:CGPointMake(13*WEIGHT+2, height-1) controlPoint1:CGPointMake(13*WEIGHT+0.6, height-1.6) controlPoint2:CGPointMake(13*WEIGHT+1, height-1.3)];
    [aPath addLineToPoint:CGPointMake(hoX-3, height-1)];
    [aPath addCurveToPoint:CGPointMake(hoX-1, height-3) controlPoint1:CGPointMake(hoX-1.6, height-1.4) controlPoint2:CGPointMake(hoX-1.3, height-2)];
    [aPath addLineToPoint:CGPointMake(hoX-1, 0)];
    
    [aPath stroke];

    
}


@end
