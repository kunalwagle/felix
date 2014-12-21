//
//  TopStoriesPageContentViewController.m
//  Felix
//
//  Created by Kunal Wagle on 21/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "TopStoriesPageContentViewController.h"

@interface TopStoriesPageContentViewController ()

@end

@implementation TopStoriesPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.image.image = [UIImage imageNamed:self.imageName];
    self.headline.text = self.contentTitle;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
