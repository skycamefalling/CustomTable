//
//  PCDMailViewController.h
//  CustomTable
//
//  Created by Patrick Donahue on 7/17/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import <MessageUI/MessageUI.h>

@interface PCDMailViewController : MFMailComposeViewController <MFMailComposeViewControllerDelegate>

-(void)showEmail;

@end
