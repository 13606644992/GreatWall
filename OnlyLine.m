//
//  OnlyLine.m
//  GreatWall
//
//  Created by 李阳 on 2016/12/28.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "OnlyLine.h"
#import "Header.h"

@implementation OnlyLine


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
    CGContextMoveToPoint(cont, 20, rect.size.height - 1);
    CGContextAddLineToPoint(cont, ScreenWindowWidth-20*HEIGHT, rect.size.height - 1);
    CGContextStrokePath(cont);

}


@end
