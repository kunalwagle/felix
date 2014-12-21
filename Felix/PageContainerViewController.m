//
//  PageContainerViewController.m
//  Felix
//
//  Created by Kunal Wagle on 21/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "PageContainerViewController.h"

@interface PageContainerViewController ()

@end

@implementation PageContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _articleTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip"];
    _articleImages = @[@"FelixLogo.png", @"felix_cat-small.png", @"Final Felix Logo HQ with line.png"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"topStoriesPageView"];
    self.pageViewController.dataSource = self;
    
    TopStoriesPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
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

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((TopStoriesPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((TopStoriesPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.articleTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (TopStoriesPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.articleTitles count] == 0) || (index >= [self.articleTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    TopStoriesPageContentViewController *contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"topStoriesPreview"];
    contentViewController.imageName = self.articleImages[index];
    contentViewController.contentTitle = self.articleTitles[index];
    contentViewController.pageIndex = index;
    
    return contentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.articleTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
