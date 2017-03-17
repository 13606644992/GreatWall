//
//  AllLine.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/16.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "AllLine.h"
#import "Header.h"

@implementation AllLine


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // Drawing code
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, LYColor_A6.CGColor);
    CGContextSetLineWidth(cont, 1);
    CGFloat lengths[] = {2.5,2.5};
    CGContextSetLineDash(cont, 0, lengths, 1.5);
    CGContextBeginPath(cont);
    CGContextMoveToPoint(cont, 15*WIDTH, rect.size.height - 1);
    CGContextAddLineToPoint(cont, ScreenWindowWidth, rect.size.height - 1);
    CGContextStrokePath(cont);
    
}


@end
