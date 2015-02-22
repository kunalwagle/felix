//
//  TodayViewController.m
//  FelixToday
//
//  Created by Kunal Wagle on 22/02/2015.
//  Copyright (c) 2015 Felix. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "FelixTodayUtilityMethods.h"
#import "Article.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateInterface];
    // Do any additional setup after loading the view from its nib.
}

- (void) updateInterface {
    Article *article = (Article*) [[NSUserDefaults standardUserDefaults] objectForKey:@"todayArticle"];
    self.articleHeadline.text = [article getTitle];
    self.articleImage.image = [[NSUserDefaults standardUserDefaults] objectForKey:@"todayImage"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    if ([FelixTodayUtilityMethods testInternetConnection]) {
    NSMutableArray *articles = [FelixTodayUtilityMethods getArticles:@"News"];
    Article *article = (Article*) [[NSUserDefaults standardUserDefaults] objectForKey:@"todayArticle"];
    if (article) {
    if ([[[articles objectAtIndex:0] getTitle] isEqualToString:[article getTitle]]) {
        completionHandler(NCUpdateResultNoData);
    }
    } else {
        article = [articles objectAtIndex:0];
        self.articleHeadline.text = [article getTitle];
        dispatch_queue_t articleImageQueue = dispatch_queue_create("Article Image Queue",NULL);
        NSLog(@"Article Image Download");
        NSString* aurl = article.getImage.getUrl;
        int width = 320;
        int height = 320;
        NSString *string = [NSString stringWithFormat:@".co.uk/%d/%d/", width, height];
        aurl = [aurl stringByReplacingOccurrencesOfString:@".co.uk/upload" withString:string];
        NSURL *url = [NSURL URLWithString:aurl];
        dispatch_async(articleImageQueue, ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            NSLog(@"Finished Article Image Download");
            if (!self.articleImage) return;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                [self.articleImage setImage:image];
                NSLog(@"Set the image");
                [[NSUserDefaults standardUserDefaults] setObject:article forKey:@"todayArticle"];
                [[NSUserDefaults standardUserDefaults] setObject:self.articleImage.image forKey:@"image"];
                
            });
            
        });
    }

        completionHandler(NCUpdateResultNewData); }
    else {
        completionHandler(NCUpdateResultFailed);
    }
}

@end
