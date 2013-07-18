//
//  PCDSocialViewController.m
//  CustomTable
//
//  Created by Patrick Donahue on 7/17/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import "PCDSocialViewController.h"

@interface PCDSocialViewController ()

@end

@implementation PCDSocialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)showTwitter
{
    NSLog(@"Twitter");
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *twitterView = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitterView setInitialText:@"Set New Text"];
        [self presentViewController:twitterView animated:YES completion:nil];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please sign into Twitter" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
}


-(void)showFacebook
{
    
    NSLog(@"Facebook");
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *faceView = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [faceView setInitialText:@"Set New Text"];
        [self presentViewController:faceView animated:YES completion:nil];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please sign into Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
}




@end

