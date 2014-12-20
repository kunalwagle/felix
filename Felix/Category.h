//
//  Category.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "Article.h"

@interface Category : NSObject

-(NSMutableArray*) getArticles;
-(Section*) getSection;

@property Section *section;
@property NSMutableArray *articles;

@end
