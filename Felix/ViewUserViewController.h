//
//  ViewUserViewController.h
//  Felix
//
//  Created by Kunal Wagle on 29/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewUserViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property User* user;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *facebook;
@property (weak, nonatomic) IBOutlet UILabel *twitter;
@property (weak, nonatomic) IBOutlet UILabel *website;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UIButton *twButton;
@property (weak, nonatomic) IBOutlet UIButton *emButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property UIViewController *vc;
@property BOOL sidebar;
- (IBAction)return:(id)sender;
- (IBAction)facebook:(id)sender;
- (IBAction)email:(id)sender;
- (IBAction)twitter:(id)sender;

@end
