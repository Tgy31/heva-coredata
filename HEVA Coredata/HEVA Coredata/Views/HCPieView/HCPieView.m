//
//  HCPieView.m
//  HEVA Coredata
//
//  Created by Tanguy Hélesbeux on 07/12/2015.
//  Copyright © 2015 Tanguy Hélesbeux. All rights reserved.
//

#import "HCPieView.h"

@implementation HCPieView

#pragma mark - View life cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = self.frame.size.width/2;
}

#pragma mark - Helpers

- (CGFloat)centerX {
    return self.frame.size.width/2;
}

- (CGFloat)centerY {
    return self.frame.size.height/2;
}

- (CGFloat)angleForValue:(CGFloat)value {
    return M_PI*3/2 + M_PI*value*2;
}

#pragma mark - Getters & Setters

- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    [self setNeedsDisplay];
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context,[self centerX], [self centerY]);
    CGContextAddArc(context,
                    [self centerX],
                    [self centerY],
                    self.frame.size.width/2,
                    [self angleForValue:0.0],
                    [self angleForValue:self.percent],
                    NO);
    
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextFillPath(context);
}

@end
