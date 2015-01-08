//
//  ViewUserViewController.m
//  Felix
//
//  Created by Kunal Wagle on 29/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "ViewUserViewController.h"
#import "RightSidebarViewController.h"
#import "UtilityMethods.h";

@interface ViewUserViewController ()

@end

@implementation ViewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name.text = self.user.getName;
    self.username.text = self.user.getUser;
    self.desc.text = self.user.getDesc;
    if ([self.desc.text isEqualToString:@""]) {
        self.desc.text = @"No description given";
    }
    self.twitter.text = self.user.getTwitter;
    if ([self.twitter.text isEqualToString:@""]) {
        self.twitter.text = @"N/A";
    }
    self.facebook.text = self.user.getFacebook;
    if ([self.facebook.text isEqualToString:@""]) {
        self.facebook.text = @"N/A";
    }
    self.email.text = self.user.getEmail;
    if ([self.email.text isEqualToString:@""]) {
        self.email.text = @"N/A";
    }
    if ([UtilityMethods testInternetConnection]) {
    NSString* imageUrl = self.user.getImage.getUrl;
    dispatch_queue_t imageQueue = dispatch_queue_create("Image Queue",NULL);
    NSLog(@"Fetching user pic");
    if (![imageUrl isEqualToString:@""] && imageUrl){
    dispatch_async(imageQueue, ^{
        
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        NSLog(@"Fetched user pic");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            // [cell.articleImage setImage:image];
            //self.loaded = YES;
            self.image.image = image;
            NSLog(@"Look at the user pic");
        });
        
    });
    }
    }
    //UIImage *image = self.user.getImage.getImage;
    //self.image.image = image;
    self.website.text = self.user.getWebsiteurl;
    if ([self.website.text isEqualToString:@""]) {
        self.website.text = @"N/A";
    }
    if ([self.facebook.text isEqualToString:@"N/A"]) {
        self.fbButton.enabled = NO;
    } else {
        self.fbButton.enabled = YES;
    }
    if ([self.twitter.text isEqualToString:@"N/A"]) {
        self.twButton.enabled = NO;
    } else {
        self.twButton.enabled = YES;
    }
    if ([self.email.text isEqualToString:@"N/A"]) {
        self.emButton.enabled = NO;
    } else {
        self.emButton.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
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

- (IBAction)return:(id)sender {
    if (!self.sidebar) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        RightSidebarViewController* viewc = (RightSidebarViewController*)self.vc;
        [self dismissViewControllerAnimated:YES completion:^{[viewc complete];}];
    }
}
- (IBAction)facebook:(id)sender {
    NSString *link = [self.facebook.text stringByReplacingOccurrencesOfString:@"www." withString:@""];
    link = [link stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    link = [link stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    NSString *final = @"http://";
    final = [final stringByAppendingString:link];
    NSURL *url = [NSURL URLWithString:final];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)email:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        NSArray *toRecipient = [[NSArray alloc] initWithObjects:self.email.text, nil];
        [mailViewController setToRecipients:toRecipient];
        [mailViewController setSubject:@"I love your section/article"];
        [mailViewController setMessageBody:@"And boy, that cat is cool." isHTML:NO];
        [self presentViewController:mailViewController animated:YES completion:nil];
    } else {
        NSLog(@"Something went wrong");
    }
}

- (IBAction)twitter:(id)sender {
    NSString *url = @"http://twitter.com/";
    url = [url stringByAppendingString:self.twitter.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult: (MFMailComposeResult)result error: (NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
