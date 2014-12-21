//
//  Article.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Image.h"
#import "Section.h"

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




@end
