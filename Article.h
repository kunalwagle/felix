//
//  Article.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "Image.h"

@interface Article : NSObject

-(int)getId;
-(NSString*)getTitle;
-(NSString*)getTeaser;
-(NSString*)getContent;
-(NSString*)getUrl;
-(NSMutableArray*)getAuthors;
-(NSMutableArray*)getComments;
-(NSString*)getCategory;
-(Image*)getImage;
-(int)getDate;
-(int)getPublished;
-(int)getCommentCount;

@property int aid;
@property NSString *title;
@property NSString *teaser;
@property NSMutableArray *authors;
@property NSString *category;
@property int date;
@property int published;
@property NSString *content;
@property Image *image;
@property NSString *url;
@property NSMutableArray *comments;
@property int comment_count;


@end
