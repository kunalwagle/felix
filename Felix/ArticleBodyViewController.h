//
//  ArticleBodyViewController.h
//  Felix
//
//  Created by Kunal Wagle on 31/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleBodyViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UILabel *teaser;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *imageCredit;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UILabel *authors;
- (IBAction)hideImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *hideImageButton;
@property BOOL loaded;
@property BOOL loading;
@property BOOL stillLoading;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property BOOL adjustedOffsets;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
