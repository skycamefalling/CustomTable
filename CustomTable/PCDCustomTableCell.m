//
//  PCDCustomTableCell.m
//  CustomTable
//
//  Created by Patrick Donahue on 6/28/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import "PCDCustomTableCell.h"

@implementation PCDCustomTableCell

@synthesize surpressDeleteButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) layoutSubviews
{
    [super layoutSubviews];
    
    //Adding the main label and detail label to the view
    CGRectMake(12, 22, 35, 35);
    float limgW =  self.imageView.image.size.width;
    if(limgW > 0) {
        self.textLabel.frame = CGRectMake(81, self.textLabel.frame.origin.y,self.textLabel.frame.size.width-10,self.textLabel.frame.size.height);
        self.detailTextLabel.frame = CGRectMake(70,self.detailTextLabel.frame.origin.y,self.detailTextLabel.frame.size.width,self.detailTextLabel.frame.size.height);

    }
    
    //Colors and images based on loading
    //Can set font color and type here as well
    self.textLabel.textColor = [UIColor whiteColor];//[UIColor colorWithRed:116.0/256.0 green:197.0/256.0 blue:197.0/256.0 alpha:1.0]; //[UIColor colorWithRed:235.0/256.0 green:176.0/256.0 blue:100.0/256.0 alpha:1.00];
    self.detailTextLabel.textColor = [UIColor blueColor];
    self.contentView.backgroundColor = [UIColor colorWithRed:243.0/256.0 green:188.0/256.0 blue:143.0/256.0 alpha:1.0];
//    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newcell.png"]];
    self.imageView.image = [UIImage imageNamed:@"newicon.png"];

    
    self.textLabel.frame = CGRectMake(50, 10, 400, 40); //self.textLabel.frame.size.width-10,self.textLabel.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(70, 50, 300, 20);
    //self.detailTextLabel.frame.size.width,self.detailTextLabel.frame.size.height;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.imageView.frame = CGRectMake(5, 10, 40, 40);

}


//Can change the color of the cell when selected
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = [UIColor colorWithRed:200.0/256.0 green:200.0/256.0 blue:200.0/256.0 alpha:1.00];
    self.selectedBackgroundView = view;
    self.textLabel.highlightedTextColor = [UIColor colorWithRed:0.255 green:0.420 blue:0.667 alpha:1.000];
    self.detailTextLabel.highlightedTextColor = [UIColor colorWithRed:0.255 green:0.420 blue:0.667 alpha:1.000];
    
    
    [super setSelected:selected animated:animated];

}

//Making sure the tableview is in the view
-(UITableView *)getTableView:(UIView *)view
{
    if (!view.superview) 
        return nil;
        
        if ([view.superview isKindOfClass:[UITableView class]]) 
            return (UITableView *)view.superview;
    
    return [self getTableView:view.superview];
           
}



//Hiding the delete button for when we swipe
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (surpressDeleteButton) {
        UITableView *tableView = [self getTableView:self];
        tableView.editing = NO;
    } else
    {
        [super setEditing:editing animated:animated];
    }
}


@end
