//
//  PCDCustomCellView.m
//  CustomTable
//
//  Created by Patrick Donahue on 7/8/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import "PCDCustomCellView.h"

@implementation PCDCustomCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

//Draw the view and colors you want for a view
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *redColor = [UIColor colorWithRed:0.0 green:10.0 blue:100.0 alpha:1.0];
    CGContextSetFillColorWithColor(context, redColor.CGColor);
    CGContextFillRect(context, self.bounds);
}

@end
