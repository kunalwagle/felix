//
//  ArticleViewController.h
//  Felix
//
//  Created by Kunal Wagle on 26/11/2013.
//  Copyright (c) 2013 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Scringo/ScringoLikeButton.h>
#import <Scringo/ScringoCommentButton.h>

@interface ArticleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *NavigationBar;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Teaser;
@property (weak, nonatomic) IBOutlet UITextView *Content;
@property (weak, nonatomic) IBOutlet UILabel *Author;
@property int ArticleNumber;
@property (weak, nonatomic) IBOutlet UIButton *SidebarButton;
- (IBAction)ShowSidebar:(id)sender;
@property (weak, nonatomic) IBOutlet ScringoLikeButton *aLikeButton;
@property (weak, nonatomic) IBOutlet ScringoCommentButton *aCommentButton;
@property NSMutableArray *Articles;
@property NSMutableArray *Teasers;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property UIImage *image;
@property NSString *Section;
- (IBAction)Done:(id)sender;

@end
