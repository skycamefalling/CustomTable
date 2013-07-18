//
//  PCDMenuController.m
//  CustomTable
//
//  Created by Patrick Donahue on 7/17/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import "PCDMenuController.h"
#import "PCDSocialViewController.h"

@implementation PCDMenuController


-(void)showMenuController
{
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    UIMenuItem *twitterItem = [[UIMenuItem alloc] initWithTitle:@"Twitter" action:@selector(showTwitter)];
    UIMenuItem *fbItem = [[UIMenuItem alloc] initWithTitle:@"Facebook" action:@selector(showFacebook)];
    UIMenuItem *mailItem = [[UIMenuItem alloc] initWithTitle:@"Email" action:@selector(showEmail)];
    
    [menuController setMenuItems:[NSArray arrayWithObjects:twitterItem,fbItem, mailItem, nil]];
    [menuController setMenuVisible:YES animated:YES];
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView
      canPerformAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender {
    return YES;  // YES for the Cut, copy, paste actions
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
         performAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender {
    NSLog(@"performAction");
}

#pragma mark - UIMenuController required methods
- (BOOL)canBecomeFirstResponder {
    // NOTE: This menu item will not show if this is not YES!
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSLog(@"canPerformAction");
    // The selector(s) should match your UIMenuItem selector
    {
        
        //      SocialMedia *socialMedia = [[SocialMedia alloc] init];
        
        
        if (action == @selector(showTwitter)) {
            return YES;
        }
        
        if (action == @selector(showFacebook)) {
            return YES;
        }
        
        
        if (action == @selector(showEmail)) {
            return YES;
        }
        
        else {
            return NO;
        }
        
    }
    
    return NO;
}

#pragma mark - Custom Action(s)
- (void)customAction:(id)sender {
    NSLog(@"custom action! %@", sender);
}


-(void)showTwitter:(PCDSocialViewController *)socialMedia
{
    [socialMedia showTwitter];
}

-(void)showFacebook:(PCDSocialViewController *)socialMedia
{
    [socialMedia showFacebook];
}

-(void)showEmail:(PCDSocialViewController *)socialMedia
{
    
    [socialMedia showEmail];
}


@end


