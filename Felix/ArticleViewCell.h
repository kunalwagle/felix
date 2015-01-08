//
//  ArticleViewCell.h
//  Felix
//
//  Created by Kunal Wagle on 22/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *articleImage;
@property (strong, nonatomic) IBOutlet UITextView *articleHeadline;

@end
