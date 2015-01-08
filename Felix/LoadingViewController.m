//
//  LoadingViewController.m
//  Felix
//
//  Created by Kunal Wagle on 30/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "LoadingViewController.h"
#import "UtilityMethods.h"
#import "articleTableViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    //[self performSelector:@selector(update) withObject:nil afterDelay:1.0f];
    self.count = 0;
    [self performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:NO];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100) {
        articleTableViewController* pvc = (articleTableViewController*)self.vc;
        [self dismissViewControllerAnimated:YES completion:^{[pvc.refreshControl endRefreshing];}];
    }
}

-(void)update{
    if ([UtilityMethods testInternetConnection]) {
    if (!self.loaded) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Felix" message:@"Welcome to the Felix app! The most recent articles will be downloaded now, and then you will be taken to the Felix Dashboard. To refresh your collection of articles pull down on the table of articles in the dashboard. Great news! You can now read all articles offline, but without images!" delegate:self cancelButtonTitle:@"TL;DR" otherButtonTitles: nil];
        [alert setTag:200];
        [alert show];
    }
    self.sections = @[@"news", @"comment", @"features", @"science", @"politics", @"arts", @"music", @"film", @"fashion", @"games", @"tech", @"travel", @"food", @"tv", @"books", @"welfare", @"cands",@"sport"];
    for (NSString *current in self.sections) {
        dispatch_queue_t imageQueue = dispatch_queue_create("Image Queue",NULL);
        dispatch_async(imageQueue, ^{
            [UtilityMethods loadArticles:current];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                NSLog(current);
                [self performSelectorOnMainThread:@selector(updateProgress:) withObject:current waitUntilDone:YES];
                self.count++;
                if (self.count==18) {
                    [self performSelectorOnMainThread:@selector(done) withObject:nil waitUntilDone:YES];
                }
            });
            
        });
    }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"You don't seem to be connected to the internet. Please connect to the internet and try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:100];
        [alert show];
        if (!self.loaded) {
            NSUserDefaults *dict = [NSUserDefaults standardUserDefaults];
            [dict setBool:NO forKey:@"hasLaunchedOnce"];
        }
    
    }
    //[self performSelectorOnMainThread:@selector(done) withObject:nil waitUntilDone:YES];
}

-(void)done{
    if (self.loaded) {
        articleTableViewController* pvc = (articleTableViewController*)self.vc;
        [self dismissViewControllerAnimated:YES completion:^{[pvc reload];}];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)updateProgress:(NSString*)current{
    if ([current isEqualToString:@"cands"]) {
        self.currentSection.text = @"Clubs and Societies";
    } else {
        self.currentSection.text = [current capitalizedString];
    }
    self.progressBar.progress = self.progressBar.progress+0.05;
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
