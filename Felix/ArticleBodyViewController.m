//
//  ArticleBodyViewController.m
//  Felix
//
//  Created by Kunal Wagle on 31/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "ArticleBodyViewController.h"
#import "FLXAppDelegate.h"
#import "User.h"
#import "UtilityMethods.h"

@interface ArticleBodyViewController ()

@end

@implementation ArticleBodyViewController

NSString *string2 = @".co.uk/325/212/";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stillLoading = YES;
    //self.adjustedOffsets;
    // Do any additional setup after loading the view.
   // [self.scrollView setContentSize:CGSizeMake(320, 600)];
    FLXAppDelegate *appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    Article* a = appDel.article;
    //NSDictionary *dictionary = appDel.colours;
    //UIColor *colour = [dictionary objectForKey:appDel.section];
    //self.view.backgroundColor = colour;
    self.header.font = [UIFont fontWithName:@"NotoSerif" size:16];
    self.teaser.font = [UIFont fontWithName:@"NotoSerif" size:13];
    self.text.editable = YES;
    self.text.font = [UIFont fontWithName:@"Neuton-Regular" size:14];
    self.text.editable = NO;
    self.header.text = a.getTitle;
    self.teaser.text = a.getTeaser;
    self.text.scrollEnabled = YES;
    self.text.text = a.getContent;
    [self.text setClipsToBounds:NO];
   // [self.text sizeToFit];
    self.text.scrollEnabled = NO;
    NSLog(self.text.text);
    NSString *byline = @"";
    for (User* user in a.getAuthors) {
        byline = [byline stringByAppendingString:user.getName];
        byline = [byline stringByAppendingString:@", "];
    }
    byline = [byline substringToIndex:[byline length]-2];
    byline = [byline uppercaseString];
    self.authors.text = byline;
    self.authors.font = [UIFont fontWithName:@"Neuton-Regular" size:14];
    if (![a.getImage.getUrl isEqualToString:@""] && a.getImage.getUrl) {
        [self.image setHidden:NO];
        if (![a.getImage.getAttribution isEqualToString:@""] && a.getImage.getAttribution) {
            [self.imageCredit setHidden:YES];
            self.imageCredit.text = a.getImage.getAttribution;
        } else {
            [self.imageCredit setHidden:YES];
        }
        self.image.image = [UIImage imageNamed:@"FelixLogo.png"];
        if ([UtilityMethods testInternetConnection]) {
            self.loading = YES;
            [self.text setContentInset:UIEdgeInsetsMake(150, 0, 0,0)];
            [self.text setContentOffset:CGPointMake(0, -350)];
            self.lastContentOffset = -150;
        dispatch_queue_t articleImageQueue = dispatch_queue_create("Article Image Queue",NULL);
        NSLog(@"Article Image Download");
        NSString* aurl = a.getImage.getUrl;
        int width = 400;
            int height = 200;
            NSString *string = [NSString stringWithFormat:@".co.uk/%d/%d/", width, height];
        aurl = [aurl stringByReplacingOccurrencesOfString:@".co.uk/upload" withString:string];
        NSURL *url = [NSURL URLWithString:aurl];
        dispatch_async(articleImageQueue, ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            NSLog(@"Finished Article Image Download");
            if (!self.image) return;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                [self.image setImage:image];
                NSLog(@"Set the image");
                
            });
            
        });
        }     else {
            [self.image setHidden:YES];
            [self.imageCredit setHidden:YES];
            [self.hideImageButton setHidden:YES];
            [self.text setContentOffset:CGPointMake(0, -180)];
            //[self.text setContentInset:UIEdgeInsetsMake(150, 0, 0,0)];
            //[self.text setFrame:CGRectMake(self.text.frame.origin.x, self.text.frame.origin.y-175, self.text.frame.size.width, self.text.frame.size.height+175)];
            //self.textViewHeightConstraint.constant = -100;
        }
    }
    else {
        [self.image setHidden:YES];
        [self.imageCredit setHidden:YES];
        [self.hideImageButton setHidden:YES];
        [self.text setContentOffset:CGPointMake(0, -180)];
       // [self.text setContentInset:UIEdgeInsetsMake(150, 0, 0,0)];
//        [self.text setFrame:CGRectMake(self.text.frame.origin.x, self.text.frame.origin.y-175, self.text.frame.size.width, self.text.frame.size.height+175)];
    }
   //[self.text scrollRectToVisible:rect animated:NO];
    //[self.text setContentOffset:UIEdgeInsetsMake(150, 0, 0, 0)];
    [self.text setFrame:CGRectMake(self.view.bounds.origin.x+145, self.text.frame.origin.y, self.view.bounds.size.width-160, self.text.frame.size.height)];
//    CGFloat fixedWidth = self.text.frame.size.width;
//    CGSize newSize = [self.text sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//    CGRect newFrame = self.text.frame;
//    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
//    self.text.frame = newFrame;
    //[self.text sizeToFit];
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+100)];
//    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+(self.text.frame.size.height-self.view.bounds.size.height)+530)];
    NSLog([NSString stringWithFormat:@"Scroll View height: %f, Text View height: %f", self.scrollView.contentSize.height, self.text.frame.size.height]);

    self.loaded = NO;
    self.loading = NO;
}

-(BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.text setScrollEnabled:YES];
    [self.text sizeToFit];
    [self.text setClipsToBounds:NO];
    [self.text setScrollEnabled:NO];
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.text.frame.size.height + self.text.frame.origin.y + 180)];
//    
//    if (self.loading == NO) {
//    if (self.loaded == NO) {
//        int currentOffset = scrollView.contentOffset.y;
//    if (self.lastContentOffset < currentOffset) {
//        if (self.stillLoading == NO) {
//        [self.image setHidden:YES];
//        [self.hideImageButton setTitle:@"V" forState:UIControlStateNormal];
//        self.loaded = YES;
//        } else {
//            self.stillLoading = NO;
//        }
//    }
//    }
//    }
//    if (self.image.hidden && !self.adjustedOffsets) {
//        int offset = scrollView.contentOffset.y;
//        if (offset>0) {
//            //[self.text setContentOffset:CGPointMake(0, 0)];
//            self.adjustedOffsets = YES;
//            [self.text setContentInset:UIEdgeInsetsMake(0, 0, 0,0)];
//        }
//    }
//    
//    
}

- (IBAction)hideImage:(id)sender {
//    if (self.image.hidden) {
//        [self.image setHidden:NO];
//        [self.hideImageButton setTitle:@"X" forState:UIControlStateNormal];
//        if (self.adjustedOffsets) {
//            self.adjustedOffsets = NO;
//            int offset = self.text.contentOffset.y;
//            [self.text setContentInset:UIEdgeInsetsMake(150, 0, 0,0)];
//            [self.text setContentOffset:CGPointMake(0, -158+offset)];
//        }
//    } else {
//        [self.image setHidden:YES];
//        [self.hideImageButton setTitle:@"V" forState:UIControlStateNormal];
//    }
}
@end
