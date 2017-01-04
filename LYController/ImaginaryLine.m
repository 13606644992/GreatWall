//
//  ImaginaryLine.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/28.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "ImaginaryLine.h"
#import "Header.h"

@implementation ImaginaryLine


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIColor *color = LYColor_A6;
    [color set];  //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(13*WEIGHT, 0)];
    // Draw the lines
    [aPath addLineToPoint:CGPointMake(13*WEIGHT, rect.size.height)];
    
    [aPath stroke];
    
    UIBezierPath* aPath1 = [UIBezierPath bezierPath];
    aPath1.lineWidth = 1.0;
    aPath1.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath1.lineJoinStyle = kCGLineCapRound;  //终点处理
    // Set the starting point of the shape.
    [aPath1 moveToPoint:CGPointMake(ScreenWindowWidth-13*WEIGHT-1, 0)];
    // Draw the lines
    [aPath1 addLineToPoint:CGPointMake(ScreenWindowWidth-13*WEIGHT-1, rect.size.height)];
    
    [aPath1 stroke];
    
    
    
    // Drawing code
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, LYColor_A6.CGColor);
    CGContextSetLineWidth(cont, 1);
    CGFloat lengths[] = {2.5,2.5};
    CGContextSetLineDash(cont, 0, lengths, 1.5);
    CGContextBeginPath(cont);
    CGContextMoveToPoint(cont, 20, rect.size.height - 1);
    CGContextAddLineToPoint(cont, ScreenWindowWidth-20*HEIGHT, rect.size.height - 1);
    CGContextStrokePath(cont);
    

    
}


@end
