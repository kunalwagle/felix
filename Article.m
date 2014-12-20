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

-(NSString*)getSection {
    return self.section;
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

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.teaser forKey:@"teaser"];
    [coder encodeInt:self.aid forKey:@"aid"];
    [coder encodeInt:self.date forKey:@"date"];
    [coder encodeInt:self.published forKey:@"published"];
    [coder encodeInt:self.comment_count forKey:@"comment_count"];
    [coder encodeObject:self.section forKey:@"section"];
    [coder encodeObject:self.authors forKey:@"authors"];
    [coder encodeObject:self.comments forKey:@"comments"];
    [coder encodeObject:self.image forKey:@"image"];
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.content forKey:@"content"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.title = [coder decodeObjectForKey:@"title"];
    self.teaser = [coder decodeObjectForKey:@"teaser"];
    self.aid = [coder decodeIntForKey:@"aid"];
    self.date = [coder decodeIntForKey:@"date"];
    self.published = [coder decodeIntForKey:@"published"];
    self.comment_count = [coder decodeIntForKey:@"comment_count"];
    self.section = [coder decodeObjectForKey:@"section"];
    self.authors = [coder decodeObjectForKey:@"authors"];
    self.comments = [coder decodeObjectForKey:@"comments"];
    self.image = [coder decodeObjectForKey:@"image"];
    self.url = [coder decodeObjectForKey:@"url"];
    self.content = [coder decodeObjectForKey:@"content"];
    return self;
}

@end
