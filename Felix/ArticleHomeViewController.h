//
//  ArticleHomeViewController.h
//  Felix
//
//  Created by Kunal Wagle on 31/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ArticleHomeViewController : UIViewController<MFMailComposeViewControllerDelegate, UIActionSheetDelegate>
- (IBAction)back:(id)sender;
- (IBAction)email:(id)sender;
- (IBAction)author:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *comments;
- (IBAction)comment:(id)sender;
- (IBAction)shareButton:(id)sender;
@property int index;
@end
