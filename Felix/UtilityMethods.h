//
//  UtilityMethods.h
//  Felix
//
//  Created by Kunal Wagle on 27/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Image.h"
#import "Section.h"

@interface UtilityMethods : NSObject

+(NSMutableArray*)setUpArticles:(NSString*)section;
+(Image*)createImage:(NSDictionary*)image;
+(Section*)createSection:(NSDictionary*)section;
+(NSMutableArray*)createUser:(NSArray*)u;
+(NSMutableArray*)getArticles:(NSString*)section;
+(void)loadArticles:(NSString*)section;
+(NSMutableDictionary*)setColours:(NSMutableDictionary*)dict;
+(BOOL)testInternetConnection;
+(NSMutableArray*)getArticlesWithoutRefreshing:(NSString*)section;


@end
