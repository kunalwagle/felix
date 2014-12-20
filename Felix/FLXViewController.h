//
//  FLXViewController.h
//  Felix
//
//  Created by Kunal Wagle on 26/11/2013.
//  Copyright (c) 2013 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLXViewController : UIViewController
- (IBAction)OpenCloseSidebar:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *Table;
@property NSMutableArray *allTitles;
@property BOOL initialiseApp;
@property NSMutableArray *Array;
@property NSMutableArray *Teaser;
@property NSString *Section;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityBar;
@property NSMutableArray *allImages;
@property NSMutableArray *allNumbers;

@end
