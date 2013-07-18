//
//  PCDViewController.m
//  CustomTable
//
//  Created by Patrick Donahue on 6/28/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import "PCDViewController.h"
#import "PCDCustomTableCell.h"
#import "PCDCustomCellView.h"
#import "PCDCustomHeader.h"
#import "PCDSocialViewController.h"
#import "PCDHiddenView.h"
#import "PCDMailViewController.h"
#import "PCDMenuController.h"

#define USE_GESTURE_RECOGNIZERS YES
#define BOUNCE_PIXELS 15.0
#define PUSH_STYLE_ANIMATION NO

@interface PCDViewController ()

-(void)addSwipeTo:(UITableViewCell *)cell direction:(UISwipeGestureRecognizerDirection)direction;
-(void)setGestureRecognizer;
-(void)swipe:(UISwipeGestureRecognizer *)recognizer direction:(UISwipeGestureRecognizerDirection)direction;

@end

@implementation PCDViewController

@synthesize tableView = _tableView;
@synthesize tableArray = _tableArray;
@synthesize animatingSwipe = _animatingSwipe;
@synthesize swipeDirection = _swipeDirection;
@synthesize hiddenCell = _hiddenCell;
@synthesize hiddenView = _hiddenView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"test";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];

    _tableArray = [[NSMutableArray alloc] initWithObjects:@"Test", @"app",@"swipe me", @"tableView", nil];
    
    self.tableView.backgroundView = nil;
    self.view.backgroundColor = [UIColor colorWithRed:116.0/256.0 green:197.0/256.0 blue:197.0/256.0 alpha:1.0];
    
    //Use an image for your background 
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openPopover)];
//    self.navigationItem.leftBarButtonItem = leftButton;
//    
    

    _animatingSwipe = NO;
    [self setupGestureRecognizers];
    [self setHiddenView];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)refreshView
{
    [_tableView reloadData];
}

-(void)setHiddenView
{
    //_hiddenView.frame = CGRectMake(0, 0, 50, 84);
    
    //Sets hidden view with the contents of PCDHiddenView
    _hiddenView = [[PCDHiddenView alloc] init];
    
    
    //This code creates the hiddenView
/*
    _hiddenView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"customBackground.png"]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 70, 30)];
    label.text = @"Test";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [_hiddenView addSubview:label];
    [self.view addSubview:_hiddenView];
    [self.view sendSubviewToBack:_hiddenView];
*/
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
    [_hiddenView addGestureRecognizer:longGesture];
    
    
}

-(void)longPress
{
    NSLog(@"Long press");
    PCDMenuController *menu = [[UIMenuController alloc] init];
    [menu showMenuController];
    [_hiddenView becomeFirstResponder];
}

-(void)openPopover
{
    
    // change to where you want it to show and how big you want it
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 100, 50)]; 
    
    customView.alpha = 1.0;
    customView.layer.cornerRadius = 5;
    customView.layer.borderWidth = 1.5f;
    customView.backgroundColor = [UIColor whiteColor];
    //customView.layer.borderColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), YourColorValues);
    customView.layer.masksToBounds = YES;
    
    [self.view addSubview:customView];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [customView setAlpha:1.0];
    [UIView commitAnimations];
    [UIView setAnimationDuration:0.0];
}


#pragma mark Gesture Recognizers

- (BOOL) gestureRecognizersSupported
{
    if (!USE_GESTURE_RECOGNIZERS) return NO;
    
    return [[[UISwipeGestureRecognizer alloc] init] respondsToSelector:@selector(locationInView:)];
}



//Attaching the gesture to the methods for swipe left and right
-(void)setupGestureRecognizers
{
    UISwipeGestureRecognizer* rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [_tableView addGestureRecognizer:rightSwipeGestureRecognizer];
    
    UISwipeGestureRecognizer* leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [_tableView addGestureRecognizer:leftSwipeGestureRecognizer];
}




//Adding the gesture recognizer to the direction of the swipe
//Also add what you want to happen here
-(void)swipeRight:(UISwipeGestureRecognizer *)recognizer
{
    [self swipe:recognizer direction:UISwipeGestureRecognizerDirectionRight];
}


-(void)swipeLeft:(UISwipeGestureRecognizer *)recognizer
{
    [self swipe:recognizer direction:UISwipeGestureRecognizerDirectionLeft];
}




//If gesture is recogonized show the view behind the cell
-(void)swipe:(UISwipeGestureRecognizer *)recognizer direction:(UISwipeGestureRecognizerDirection)direction
{
    if (recognizer && recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location= [recognizer locationInView:_tableView];
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:location];
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.frame.origin.x !=0)
        {
            [self removeHiddenView:YES];
            return;
        }
        
        [self removeHiddenView:NO];
       
        PCDCustomTableCell *tableCell = [[PCDCustomTableCell alloc] init];
       
            if (cell != tableCell)
        {
            [self addSwipeTo:cell direction:direction];
        }
    }
    
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
    
    //return [_tableArray count];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundView.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    tableView.separatorColor = [UIColor whiteColor];

    
    PCDCustomTableCell *cell =[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {

        cell = [[PCDCustomTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
        cell.textLabel.text = [_tableArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.imageView.frame = CGRectMake(5, 20, 40, 40);
        cell.imageView.image = [UIImage imageNamed:@"newicon.png"];
        cell.detailTextLabel.text = @"Test";
        cell.backgroundColor = [UIColor clearColor];
        
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 84;
}

#pragma mark tableview header

//Add a title to the header for each section
/*
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Test Header";
    }
}
*/


//Creating a view for the Header
//Do this with a subclass file or just some code here
- (UIView *)tableView : (UITableView *)tableView viewForHeaderInSection : (NSInteger) section
{
    
    //This is for the custom header files
    PCDCustomHeader *header = [[PCDCustomHeader alloc] init];
    header.headerLabel.text = @"Test Header";
    return header;
    
   
    
    //Code to customize the header without a file
/*
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
   // headerView.backgroundColor = [UIColor colorWithRed:45.0/256.0 green:104.0/256.0 blue:104.0/256.0 alpha:0.50];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerImage.png"]];
    imageView.frame = CGRectMake(0, 0, 300, 30);
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 3, 200, 20)];
    headerLabel.text = @"Test Header";
    headerLabel.font = [UIFont fontWithName:@"Zapfino" size:15.0];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor colorWithRed:235.0/256.0 green:176.0/256.0 blue:100.0/256.0 alpha:1.00];
    [headerView addSubview:imageView];
    [headerView addSubview:headerLabel];

    
    return headerView;
 */
 
 
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}





#pragma mark edit tableview

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


//If we want to swipe a tablecell we cannot have the delete button show
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if ([self gestureRecognizersSupported])
        return NO;
    else
        
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Code to delete the item from the table cell
    /*
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_tableArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
    */
}


//Adding the gesture to the cell
-(void)addSwipeTo:(UITableViewCell *)cell direction:(UISwipeGestureRecognizerDirection)direction
{
    _hiddenView.frame = cell.frame;
    
        
    // Add the side swipe view to the table below the cell
    [_tableView insertSubview:_hiddenView belowSubview:cell];
    
    // Remember which cell the hidden view is displayed on and the swipe direction
    self.hiddenCell = cell;
    _swipeDirection = direction;
    
    CGRect cellFrame = cell.frame;
    if (PUSH_STYLE_ANIMATION)
    {
        // Move the tablecell offscreen either to the left or the right depending on the swipe direction
        /*
        _hiddenView.frame = CGRectMake(direction == UISwipeGestureRecognizerDirectionRight ? -cellFrame.size.width : cellFrame.size.width, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
        */
        
        _hiddenView.frame = CGRectMake(direction == UISwipeGestureRecognizerDirectionRight ? -cellFrame.size.width : cellFrame.size.width, cellFrame.origin.y, 300, cellFrame.size.height);
    }
    else
    {
        // Move the tablecell to offset 0
     //   _hiddenView.frame = CGRectMake(0, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
        _hiddenView.frame = CGRectMake(0, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
    }
    
    // Animate in the side swipe view
    _animatingSwipe = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStopAddingSwipeView:finished:context:)];
    
    
    if (PUSH_STYLE_ANIMATION)
    {
        // Move the side swipe view to offset 0
        // While simultaneously moving the cell's frame offscreen
        // The net effect is that the side swipe view is pushing the cell offscreen
        _hiddenView.frame = CGRectMake(0, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
    }
    
    // Change the 200 if you want the cell to not leave the screen when swiping to the right or
    // put cellFrame.size.width in its place if you want it to leave the screen
    cell.frame = CGRectMake(direction == UISwipeGestureRecognizerDirectionRight ? 200 : -cellFrame.size.width, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
    
    [UIView commitAnimations];
    
}

- (void)animationDidStopAddingSwipeView:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    _animatingSwipe = NO;
}


#pragma mark Selecting a cell

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSString *text = [_tableArray objectAtIndex:indexPath.row];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tapped!"
//                                                    message:[NSString stringWithFormat:@"You tapped %@ cell", text]
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil, nil];
//    [alert show];
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

//If you want to use segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSString *name = [_tableArray objectAtIndex:indexPath.row];
//        [[segue destinationViewController] setDetailItem:name];
//    }
}

#pragma mark Animation
- (void) removeHiddenView:(BOOL)animated
{
    // Make sure we have a cell where the side swipe view appears and that we aren't in the middle of animating
    if (!_hiddenCell || _animatingSwipe) return;
    
    if (animated)
    {
        // The first step in a bounce animation is to move the view a bit offscreen
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if (_swipeDirection == UISwipeGestureRecognizerDirectionRight)
        {
            if (PUSH_STYLE_ANIMATION)
                _hiddenView.frame = CGRectMake(-_hiddenView.frame.size.width + BOUNCE_PIXELS,_hiddenView.frame.origin.y,_hiddenView.frame.size.width, _hiddenView.frame.size.height);
            _hiddenCell.frame = CGRectMake(BOUNCE_PIXELS, _hiddenCell.frame.origin.y, _hiddenCell.frame.size.width, _hiddenCell.frame.size.height);
        }
        else
        {
            if (PUSH_STYLE_ANIMATION)
                _hiddenView.frame = CGRectMake(_hiddenView.frame.size.width - BOUNCE_PIXELS,_hiddenView.frame.origin.y,_hiddenView.frame.size.width, _hiddenView.frame.size.height);
            _hiddenCell.frame = CGRectMake(-BOUNCE_PIXELS, _hiddenCell.frame.origin.y, _hiddenCell.frame.size.width, _hiddenCell.frame.size.height);
        }
        _animatingSwipe = YES;
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStopOne:finished:context:)];
        [UIView commitAnimations];
    }
    else
    {
        [_hiddenView removeFromSuperview];
        _hiddenCell.frame = CGRectMake(0,_hiddenCell.frame.origin.y,_hiddenCell.frame.size.width, _hiddenCell.frame.size.height);
        self.hiddenCell = nil;
    }
}

#pragma mark Bounce animation when removing the side swipe view
// The next step in a bounce animation is to move the side swipe view a bit on screen
- (void)animationDidStopOne:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    if (_swipeDirection == UISwipeGestureRecognizerDirectionRight)
    {
        if (PUSH_STYLE_ANIMATION)
            _hiddenView.frame = CGRectMake(-_hiddenView.frame.size.width + BOUNCE_PIXELS*2,_hiddenView.frame.origin.y,_hiddenView.frame.size.width, _hiddenView.frame.size.height);
        _hiddenCell.frame = CGRectMake(BOUNCE_PIXELS*2, _hiddenCell.frame.origin.y, _hiddenCell.frame.size.width, _hiddenCell.frame.size.height);
    }
    else
    {
        if (PUSH_STYLE_ANIMATION)
            _hiddenView.frame = CGRectMake(_hiddenView.frame.size.width - BOUNCE_PIXELS*2,_hiddenView.frame.origin.y,_hiddenView.frame.size.width, _hiddenView.frame.size.height);
        _hiddenCell.frame = CGRectMake(-BOUNCE_PIXELS*2, _hiddenCell.frame.origin.y, _hiddenCell.frame.size.width, _hiddenCell.frame.size.height);
    }
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStopTwo:finished:context:)];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView commitAnimations];
}

// The final step in a bounce animation is to move the side swipe completely offscreen
- (void)animationDidStopTwo:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    if (_swipeDirection == UISwipeGestureRecognizerDirectionRight)
    {
        if (PUSH_STYLE_ANIMATION)
            _hiddenView.frame = CGRectMake(-_hiddenView.frame.size.width ,_hiddenView.frame.origin.y,_hiddenView.frame.size.width, _hiddenView.frame.size.height);
        _hiddenCell.frame = CGRectMake(0, _hiddenCell.frame.origin.y, _hiddenCell.frame.size.width, _hiddenCell.frame.size.height);
    }
    else
    {
        if (PUSH_STYLE_ANIMATION)
            _hiddenView.frame = CGRectMake(_hiddenView.frame.size.width ,_hiddenView.frame.origin.y,_hiddenView.frame.size.width, _hiddenView.frame.size.height);
        _hiddenCell.frame = CGRectMake(0, _hiddenCell.frame.origin.y, _hiddenCell.frame.size.width, _hiddenCell.frame.size.height);
    }
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStopThree:finished:context:)];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView commitAnimations];
}

// When the bounce animation is completed, remove the side swipe view and reset some state
- (void)animationDidStopThree:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    _animatingSwipe = NO;
    self.hiddenCell = nil;
    [_hiddenView removeFromSuperview];
}

@end
