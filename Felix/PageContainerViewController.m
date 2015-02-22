//
//  PageContainerViewController.m
//  Felix
//
//  Created by Kunal Wagle on 21/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "PageContainerViewController.h"
#import "FelixUtilityMethods.h"
#import "Article.h"
#import "FLXAppDelegate.h"
#import "RightSidebarViewController.h"

@interface PageContainerViewController ()

@end

@implementation PageContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FLXAppDelegate *appDel = (FLXAppDelegate*) [UIApplication sharedApplication].delegate;
    appDel.pageContainerViewController = self;
    NSString* sect = appDel.section;
    //_articleTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip"];
    NSArray *articles = [FelixUtilityMethods getArticles:sect];
    self.articleTitles = [[NSMutableArray alloc] initWithObjects: nil];
    self.articleImages = [[NSMutableArray alloc] initWithObjects: nil];
    self.articles = [[NSMutableArray alloc] initWithObjects:nil];
    for (int i=0; i<[articles count] && i<3; i++) {
        @try {
        Article *a = [articles objectAtIndex:i];
        NSString *title = a.getTitle;
        NSString* image = a.getImage.getUrl;
        if (!image || [image isEqualToString:@""]) {
            [self.articleImages addObject:@"FelixLogo.png"];
        } else {
            [self.articleImages addObject:image];
        }
        [self.articleTitles addObject:title];
        [self.articles addObject:articles[i]];
        }
        @catch (NSException *e) {
        }
        @finally{
        }
    }
    if ([articles count]>0) {
    Article* article = [articles objectAtIndex:0];
    Section *section = article.getSection;
    RightSidebarViewController *r = appDel.rightSidebar;
    [r reloadAllData:section author:NULL];
    appDel.article = article;
    }
    //_articleImages = @[@"FelixLogo.png", @"felix_cat-small.png", @"Final Felix Logo HQ with line.png"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"topStoriesPageView"];
    self.pageViewController.dataSource = self;
    for (UIViewController *vc in [self childViewControllers]) {
        [vc removeFromParentViewController];
    }
    TopStoriesPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers;
    if (startingViewController!=NULL) {
        viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        // Change the size of page view controller
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
        [self.pageViewController didMoveToParentViewController:self];
    } else {
        viewControllers = [[NSArray alloc] initWithObjects: nil];
    }
    
}


-(void)reloadData:(NSString*)sect {
//    FLXAppDelegate *appDel = (FLXAppDelegate*) [UIApplication sharedApplication].delegate;
//    NSArray *articles = [FelixUtilityMethods getArticles:sect];
//    self.articleTitles = [[NSMutableArray alloc] initWithObjects: nil];
//    self.articleImages = [[NSMutableArray alloc] initWithObjects: nil];
//    for (int i=0; i<[articles count] && i<3; i++) {
//        Article *a = [articles objectAtIndex:i];
//        NSString *title = a.getTitle;
//        UIImage *image = a.getImage.getImage;
//        [self.articleTitles addObject:title];
//        if (image != NULL) {
//            [self.articleImages addObject:image];
//        } else {
//            [self.articleImages addObject:[UIImage imageNamed:@"FelixLogo.png"]];
//        }
//    }
//    Article* article = [articles objectAtIndex:0];
//    Section *section = article.getSection;
//    RightSidebarViewController *r = appDel.rightSidebar;
//    [r reloadAllData:section author:NULL];
//    appDel.article = article;
//    //_articleImages = @[@"FelixLogo.png", @"felix_cat-small.png", @"Final Felix Logo HQ with line.png"];
//    for (int i=0; i<[[self childViewControllers] count]; i++) {
//        UIViewController *vc = [[self childViewControllers] objectAtIndex:i];
//        [vc removeFromParentViewController];
//    }
//    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"topStoriesPageView"];
//    self.pageViewController.dataSource = self;
//    
//    TopStoriesPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
//    NSArray *viewControllers;
//    if (startingViewController!=NULL) {
//        viewControllers = @[startingViewController];
//        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
//        // Change the size of page view controller
//        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        
//        [self addChildViewController:_pageViewController];
//        [self.view addSubview:_pageViewController.view];
//        [self.pageViewController didMoveToParentViewController:self];
//    } else {
//        viewControllers = [[NSArray alloc] initWithObjects: nil];
//    }
   // self.section = sect;
    FLXAppDelegate *appDel = (FLXAppDelegate*) [UIApplication sharedApplication].delegate;
    appDel.pageContainerViewController = self;
    //_articleTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip"];
    NSArray *articles = [FelixUtilityMethods getArticles:sect];
    self.articleTitles = [[NSMutableArray alloc] initWithObjects: nil];
    self.articleImages = [[NSMutableArray alloc] initWithObjects: nil];
    self.articles = [[NSMutableArray alloc] initWithObjects:nil];
    for (int i=0; i<[articles count] && i<3; i++) {
        @try {
            Article *a = [articles objectAtIndex:i];
            NSString *title = a.getTitle;
            NSString* image = a.getImage.getUrl;
            if (!image || [image isEqualToString:@""]) {
                [self.articleImages addObject:@"FelixLogo.png"];
            } else {
                [self.articleImages addObject:image];
            }
            [self.articleTitles addObject:title];
            [self.articles addObject:articles[i]];
        }
        @catch (NSException *e) {
        }
        @finally{
        }
    }
    Article* article = [articles objectAtIndex:0];
    Section *section = article.getSection;
    RightSidebarViewController *r = appDel.rightSidebar;
    [r reloadAllData:section author:NULL];
    appDel.article = article;
    TopStoriesPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers;
    if (startingViewController!=NULL) {
        viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        // Change the size of page view controller
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
        [self.pageViewController didMoveToParentViewController:self];
    } else {
        viewControllers = [[NSArray alloc] initWithObjects: nil];
    }

    [self.view setNeedsDisplay];
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
    contentViewController.article = self.articles[index];
    
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
