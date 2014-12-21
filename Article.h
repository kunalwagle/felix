//
//  Article.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "Image.h"
#include "Section.h"

@interface Article : NSObject

-(Article*)initFull: (int)aid title:(NSString*)title teaser:(NSString*)teaser content:(NSString*)content url:(NSString*)url authors:(NSMutableArray*)authors comments:(NSMutableArray*)comments section:(Section*)section image:(Image*)image date:(int)date published:(int)published comment_count:(int)comment_count;
-(int)getId;
-(NSString*)getTitle;
-(NSString*)getTeaser;
-(NSString*)getContent;
-(NSString*)getUrl;
-(NSMutableArray*)getAuthors;
-(NSMutableArray*)getComments;
-(Section*)getSection;
-(Image*)getImage;
-(int)getDate;
-(int)getPublished;
-(int)getCommentCount;

@property int aid;
@property NSString *title;
@property NSString *teaser;
@property NSMutableArray *authors;
@property Section *section;
@property int date;
@property int published;
@property NSString *content;
@property Image *image;
@property NSString *url;
@property NSMutableArray *comments;
@property int comment_count;


@end
