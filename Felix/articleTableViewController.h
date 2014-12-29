//
//  articleTableViewController.h
//  Felix
//
//  Created by Kunal Wagle on 22/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface articleTableViewController : UITableViewController

@property NSMutableArray *articleTitles;
@property NSMutableArray *articleImages;
-(void)reloadData:(NSString*)section;

@end
