//
//  FLXAppDelegate.h
//  Felix
//
//  Created by Kunal Wagle on 26/11/2013.
//  Copyright (c) 2013 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RightSidebarViewController.h"
#import "PageContainerViewController.h"
#import "articleTableViewController.h"
#import "Article.h"

@interface FLXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property RightSidebarViewController *rightSidebar;
@property PageContainerViewController *pageContainerViewController;
@property articleTableViewController *articleTableVC;
@property UIViewController *previousViewController;
@property Article* article;
@property NSString* section;
@property NSMutableArray* loadedTop;
@property NSMutableDictionary* loadedBottom;
@property NSMutableDictionary* colours;
@property Article* todayArticle;

@end
