//
//  Category.h
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "Article.h"
#include "Section.h"

@interface Category : NSObject

-(Category *)initFull: (Section*)section articles:(NSMutableArray*)articles;
-(NSMutableArray*) getArticles;
-(Section*) getSection;



@end
