//
//  Category.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "Category.h"

@implementation Category

-(NSMutableArray*)getArticles {
    return self.getArticles;
}

-(Section*)getSection {
    return self.section;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.section forKey:@"section"];
    [coder encodeObject:self.articles forKey:@"articles"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.section = [coder decodeObjectForKey:@"section"];
    self.articles = [coder decodeObjectForKey:@"articles"];
    return self;
}

@end
