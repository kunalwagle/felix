//
//  ArticleViewCell.m
//  Felix
//
//  Created by Kunal Wagle on 22/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "ArticleViewCell.h"

@implementation ArticleViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.articleHeadline = [[UITextView alloc] init];
        self.articleImage = [[UIImageView alloc] init];
    }
    return self;
}

@end
