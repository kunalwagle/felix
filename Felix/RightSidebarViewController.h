//
//  RightSidebarViewController.h
//  Felix
//
//  Created by Kunal Wagle on 26/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Section.h"

@interface RightSidebarViewController : UITableViewController

@property NSMutableArray *section;
@property NSMutableArray *author;
@property NSMutableArray *issues;

-(void)reloadAllData:(Section*)section author:(NSMutableArray*)author;

@end
