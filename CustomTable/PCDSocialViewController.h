//
//  PCDSocialViewController.h
//  CustomTable
//
//  Created by Patrick Donahue on 7/17/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>



@interface PCDSocialViewController : UIViewController <MFMailComposeViewControllerDelegate>


-(void)showTwitter;
-(void)showFacebook;
-(void)showEmail;



@end
