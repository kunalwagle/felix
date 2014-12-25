//
//  RightSidebarViewController.h
//  Felix
//
//  Created by Kunal Wagle on 26/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightSidebarViewController : UITableViewController

@property UIViewController *currentViewController;
@property NSMutableArray *section;
@property NSMutableArray *author;
@property NSMutableArray *issues;

@end
