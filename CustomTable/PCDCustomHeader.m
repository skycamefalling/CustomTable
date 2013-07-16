//
//  PCDCustomHeader.m
//  CustomTable
//
//  Created by Patrick Donahue on 7/8/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import "PCDCustomHeader.h"

@implementation PCDCustomHeader

@synthesize headerLabel = _headerLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//Adding the color and fonts for the label for the headerview
-(id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.textAlignment = NSTextAlignmentLeft;
        _headerLabel.opaque = NO;
        _headerLabel.backgroundColor = [UIColor clearColor];
        _headerLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _headerLabel.shadowOffset = CGSizeMake(0, -1);
        
        [self addSubview:_headerLabel];
       
       
    }
    return self;
}


//Putting the headerlabel size
-(void)layoutSubviews
{
    self.headerLabel.frame = CGRectMake(1, 1, self.bounds.size.width, self.bounds.size.height);
}


//Adding the color and size for the view
-(void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIColor *backgroundColor = [UIColor colorWithRed:82.0/256.0 green:168.0/256.0 blue:185.0/256.0 alpha:1.0];
    UIColor *backgroundColor = [UIColor clearColor];
    
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);
}


@end
