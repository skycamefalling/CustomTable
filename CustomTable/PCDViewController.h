//
//  PCDViewController.h
//  CustomTable
//
//  Created by Patrick Donahue on 6/28/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PCDViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic) UISwipeGestureRecognizerDirection swipeDirection;
@property (nonatomic) BOOL animatingSwipe;
@property (nonatomic, retain) UIView *hiddenView;
@property (nonatomic, retain) UITableViewCell *hiddenCell;


-(void) removeHiddenView:(BOOL)animated;
-(BOOL) gestureRecognizersSupported;

@end
