//
//  TopStoriesPageContentViewController.h
//  Felix
//
//  Created by Kunal Wagle on 21/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopStoriesPageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *headline;
@property NSUInteger pageIndex;
@property UIImage *imageName;
@property NSString *contentTitle;
@end
