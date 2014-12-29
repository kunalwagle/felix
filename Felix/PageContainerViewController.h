//
//  PageContainerViewController.h
//  Felix
//
//  Created by Kunal Wagle on 21/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopStoriesPageContentViewController.h"

@interface PageContainerViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *articleTitles;
@property (strong, nonatomic) NSMutableArray *articleImages;
-(void)reloadData:(NSString*)sect;

@end
