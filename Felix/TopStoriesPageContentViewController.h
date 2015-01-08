//
//  TopStoriesPageContentViewController.h
//  Felix
//
//  Created by Kunal Wagle on 21/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Article.h"

@interface TopStoriesPageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *headline;
@property NSUInteger pageIndex;
@property NSString *imageName;
@property NSString *contentTitle;
@property Article *article;
@property BOOL loaded;
@end
