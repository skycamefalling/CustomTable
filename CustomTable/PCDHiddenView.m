//
//  PCDHiddenView.m
//  CustomTable
//
//  Created by Patrick Donahue on 7/17/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import "PCDHiddenView.h"

@implementation PCDHiddenView

@synthesize cellLabel = _cellLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        _cellLabel = [[UILabel alloc] init];
        _cellLabel.textAlignment = NSTextAlignmentLeft;
        _cellLabel.opaque = NO;
        _cellLabel.backgroundColor = [UIColor clearColor];
//        _cellLabel.font = [UIFont boldSystemFontOfSize:15.0];
//        _cellLabel.font = [UIFont systemFontOfSize:15.0];
        _cellLabel.font = [UIFont fontWithName:@"Zapfino" size:15.0];
        _cellLabel.textColor = [UIColor whiteColor];
        _cellLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _cellLabel.shadowOffset = CGSizeMake(0, -1);
        
        _cellLabel.text = @"Test";
        
        [self addSubview:_cellLabel];
        
    }
    
    return self;

}

-(void)layoutSubviews
{
    self.cellLabel.frame = CGRectMake(10, 1, self.bounds.size.width, self.bounds.size.height);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    
//   
//
//}

@end
