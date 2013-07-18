//
//  PCDMailViewController.m
//  CustomTable
//
//  Created by Patrick Donahue on 7/17/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import "PCDMailViewController.h"

@interface PCDMailViewController ()

@end

@implementation PCDMailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showEmail
{
    if ([MFMailComposeViewController canSendMail]) {
        NSLog(@"Email");
        
        MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
        mailView.mailComposeDelegate= self;
        [mailView setSubject:@"Replace this text"];
        [mailView setMessageBody:@"Replace this text" isHTML:NO];
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
        [self presentViewController:mailView animated:YES completion:nil];
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please sign into Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
