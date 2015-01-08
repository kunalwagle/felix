//
//  ArticleHomeViewController.m
//  Felix
//
//  Created by Kunal Wagle on 31/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "ArticleHomeViewController.h"
#import "FLXAppDelegate.h"
#import "User.h"
#import "ViewUserViewController.h"

@interface ArticleHomeViewController ()

@end

@implementation ArticleHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FLXAppDelegate* appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *section = appDel.section;
    NSMutableDictionary *dict = appDel.colours;
    UIColor *colour = [dict objectForKey:section];
    self.view.backgroundColor = colour;
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
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

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)email:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        FLXAppDelegate* appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *url = appDel.article.getUrl;
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"I love this article"];
        [mailViewController setMessageBody:[NSString stringWithFormat:@"The article can be found at: %@ . \n \n \n And boy, that cat is cool.", url] isHTML:NO];
        [self presentViewController:mailViewController animated:YES completion:nil];
    } else {
        NSLog(@"Something went wrong");
    }
}

- (IBAction)author:(id)sender {
    FLXAppDelegate* appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *authors = appDel.article.getAuthors;
    if ([authors count]>1) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What do you want to do with the file?"
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles: nil];
        for (User* user in authors) {
            [actionSheet addButtonWithTitle:user.getName];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        [actionSheet showInView:self.view];
    } else {
        [self performSegueWithIdentifier:@"user" sender:self];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    FLXAppDelegate* appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *authors = appDel.article.getAuthors;
    if (buttonIndex < [authors count]) {
        self.index = buttonIndex;
        [self performSegueWithIdentifier:@"user" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FLXAppDelegate* appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *authors = appDel.article.getAuthors;
    if ([[segue identifier] isEqualToString:@"user"]) {
        ViewUserViewController *dvc = (ViewUserViewController*)[segue destinationViewController];
        if ([authors count]==1) {
            dvc.user = [authors objectAtIndex:0];
        } else {
            dvc.user = [authors objectAtIndex:self.index];
        }
    }
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult: (MFMailComposeResult)result error: (NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)comment:(id)sender {
    FLXAppDelegate* appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *url = appDel.article.getUrl;
    url = [url stringByAppendingString:@"/#commentHeader"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
