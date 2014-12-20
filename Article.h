//
//  Article.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property int id;
@property NSString *title;
@property NSString *teaser;
@property NSMutableArray *authors;
@property Category *category;
@property int date;
@property int published;
@property NSString *content;
@property Image *image;
@property NSString *url;
@property NSMutableArray *comments;
@property int comment_count;


@end
