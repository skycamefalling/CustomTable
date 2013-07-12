//
//  PCDAppDelegate.m
//  CustomTable
//
//  Created by Patrick Donahue on 6/28/13.
//  Copyright (c) 2013 Patrick Donahue. All rights reserved.
//

#import "PCDAppDelegate.h"
#import "PCDViewController.h"

@implementation PCDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PCDViewController *mainView = [storyBoard instantiateViewControllerWithIdentifier:@"mainView"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainView];
    self.window.rootViewController = navController;
    
    navController.navigationBar.tintColor = [UIColor colorWithRed:231.0/256.0 green:136.0/256.0 blue:58.0/256.0 alpha:1.00];
//    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:116.0/256.0 green:197.0/256.0 blue:197.0/256.0 alpha:1.00], UITextAttributeTextColor, [UIColor grayColor], UITextAttributeTextShadowColor, nil];
      NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIColor grayColor], UITextAttributeTextShadowColor, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
