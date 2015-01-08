//
//  TopStoriesPageContentViewController.m
//  Felix
//
//  Created by Kunal Wagle on 21/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "TopStoriesPageContentViewController.h"
#import "FLXAppDelegate.h"
#import "UtilityMethods.h"

@interface TopStoriesPageContentViewController ()

@end

@implementation TopStoriesPageContentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    FLXAppDelegate *appDelegate = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *loaded = appDelegate.loadedTop;
    if ([self.imageName isEqualToString:@"FelixLogo.png"])
    {
        self.image.image = [UIImage imageNamed:self.imageName];
    } else if ([loaded count]>self.pageIndex) {
        self.image.image = [loaded objectAtIndex:self.pageIndex];
    } else {
        self.image.image = [UIImage imageNamed:self.imageName];
        if ([UtilityMethods testInternetConnection]) {
        dispatch_queue_t imageQueue = dispatch_queue_create("Image Queue",NULL);
        NSLog(@"Started asynchrously attempting download");
        dispatch_async(imageQueue, ^{
            NSError *error = nil;
            NSString *string = self.imageName;
            int width = self.image.bounds.size.width;
            int height = self.image.bounds.size.height;
            NSString *string2 = [NSString stringWithFormat:@".co.uk/%d/%d/", width, height];
            string = [string stringByReplacingOccurrencesOfString:@".co.uk/upload" withString:string2];
            NSURL *url = [NSURL URLWithString:string];
            NSData *imageData = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
            UIImage *image = [UIImage imageWithData:imageData];
            NSLog(@"Finished asynchrously attempting download");
            if (error)
                NSLog(@"Download error: %@", error);
            if (!self.image) return;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                // Update the UI
                [self.image setImage:image];
                self.loaded = YES;
                [loaded addObject:image];
                NSLog(@"Set the image");
                } else {
                    [self.image setImage:[UIImage imageNamed:@"FelixLogo.png"]];
                    self.loaded = YES;
                    [loaded addObject:[UIImage imageNamed:@"FelixLogo.png"]];
                }
            });
            
        });
        }
    }
    self.headline.editable = YES;
    self.headline.font = [UIFont fontWithName:@"NotoSerif" size:14];
    self.headline.editable = NO;
    self.headline.text = self.contentTitle;
    NSLog(self.headline.font.fontName);
    [self.headline.layoutManager ensureLayoutForTextContainer:self.headline.textContainer];
    self.headline.textColor = [UIColor whiteColor];
    self.headline.contentOffset = CGPointMake(0, 1);
    self.headline.contentOffset = CGPointMake(0, 0);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    tap.delegate = self;
    tap2.delegate = self;
    [self.image addGestureRecognizer:tap2];
    [self.headline addGestureRecognizer:tap];
}

-(void)tapped{
    [self performSegueWithIdentifier:@"article" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"article"]) {
        FLXAppDelegate *appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
        appDel.article = self.article;
        RightSidebarViewController *rightSidebar = appDel.rightSidebar;
        [rightSidebar reloadAllData:appDel.article.getSection author:appDel.article.getAuthors];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
