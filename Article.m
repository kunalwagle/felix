//
//  Article.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "Article.h"

@interface Article()

-(NSString*)stringByStrippingHTML;

@end

@implementation Article

-(NSMutableArray*)getAuthors {
    return self.authors;
}

-(int)getId {
    return self.aid;
}
-(NSString*)getTitle {
    return self.title;
}

-(NSString*)getTeaser {
    return self.teaser;
}

-(NSString*)getContent {
    return self.stringByStrippingHTML;
}

-(NSString*)getUrl {
    return self.url;
}

-(NSMutableArray*)getComments {
    return self.comments;
}

-(NSString*)getCategory {
    return self.category;
}

-(Image*)getImage {
    return self.image;
}

-(int)getDate {
    return self.date;
}
-(int)getPublished {
    return self.published;
}

-(int)getCommentCount {
    return self.comment_count;
}

-(NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *finalContent = self.content.copy;
    
    while ((r = [finalContent rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        finalContent = [finalContent stringByReplacingCharactersInRange:r withString:@""];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"-"];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"'"];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&pound;" withString:@"£"];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"e"];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\""];
    
    return finalContent;
}

@end
