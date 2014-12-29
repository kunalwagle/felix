//
//  FLXAppDelegate.m
//  Felix
//
//  Created by Kunal Wagle on 26/11/2013.
//  Copyright (c) 2013 Felix. All rights reserved.
//

#import "FLXAppDelegate.h"
#import "FLXViewController.h"
#import "UtilityMethods.h"
//#import <Scringo/Scringo.h>

@implementation FLXAppDelegate

//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    [Scringo didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
//}
//
//- (void)application:(UIApplication *)application
//didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    [Scringo didFailToRegisterForRemoteNotificationsWithError:error];
//}
//
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url
// sourceApplication:(NSString *)sourceApplication
//        annotation:(//)annotation {
//    return [Scringo handleOpenURL:url];
//}
//
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [Scringo didReceiveRemoteNotification:userInfo];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
   // [Scringo initWithAppId:@"YOUR_SCRINGO_APP_ID" completion:nil];
//    [Scringo initWithAppId:@"11pMbmOQyUXhHotlqDm4uFWDqFgMVPFp" completion:nil];
  //  [Scringo addSidebar:self.window toLeft:YES];
//    [Scringo initWithAppId:@"11pMbmOQyUXhHotlqDm4uFWDqFgMVPFp" completion:^{
//        [Scringo openMenuWithNavigationController:nil withScringoNavControllerEnabled:YES];
        // Add test users to show some dummy traffic
      //  [Scringo setTestMode:YES];
    //}];
        // Add test users to show some dummy traffic
        // Add test users to show some dummy traffic
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.backgroundColor = [UIColor clearColor];
    return YES;
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions  {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"firstRun"]==YES) {
        [UtilityMethods loadArticles:@"Home"];
        [userDefaults setObject:@"NO" forKey:@"firstRun"];
    }
    self.section = @"news";
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
