//
//  DashboardViewController.m
//  Felix
//
//  Created by Kunal Wagle on 21/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "DashboardViewController.h"

#import "SWRevealViewController.h"
#import "UtilityMethods.h"
#import "PageContainerViewController.h"
#import "FLXAppDelegate.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.section==NULL) {
        self.section = @"News";
    }
    self.navItem.title = self.section;
    if ([self.section isEqualToString:@"Cands"]) {
        self.navItem.title = @"Clubs and Societies";
    }
    if ([self.section isEqualToString:@"tv"]) {
        self.navItem.title = @"Television";
    }
    

    
    FLXAppDelegate *appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary* dictionary = appDel.colours;
    UIColor *colour = [dictionary objectForKey:appDel.section];
    self.view.backgroundColor = colour;
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [_rightSidebarButton addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

-(void)setColour{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
