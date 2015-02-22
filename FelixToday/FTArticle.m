//
//  FTFTArticle.m
//  Felix
//
//  Created by Kunal Wagle on 20/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "FTArticle.h"

@interface FTArticle()

-(NSString*)stringByStrippingHTML;

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

@implementation FTArticle

-(FTArticle*)initFull: (int)aid title:(NSString*)title teaser:(NSString*)teaser content:(NSString*)content url:(NSString*)url authors:(NSMutableArray*)authors comments:(NSMutableArray*)comments section:(Section*)section image:(Image*)image date:(int)date published:(int)published comment_count:(int)comment_count {
    self.aid = aid;
    self.title = title;
    self.teaser = teaser;
    self.content = content;
    self.url = url;
    self.authors = authors;
    self.comments = comments;
    self.section = section;
    self.image = image;
    self.date = date;
    self.published = published;
    self.comment_count = comment_count;
    return self;
}

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

-(Section*)getSection {
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
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n\n"];
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
    finalContent = [finalContent stringByReplacingOccurrencesOfString:@"&euml" withString:@"e"];
    
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
    self = [super init];
    self.title = [[coder decodeObjectForKey:@"title"] copy];
    self.teaser = [[coder decodeObjectForKey:@"teaser"] copy];
    self.aid = [coder decodeIntForKey:@"aid"];
    self.date = [coder decodeIntForKey:@"date"];
    self.published = [coder decodeIntForKey:@"published"];
    self.comment_count = [coder decodeIntForKey:@"comment_count"];
    self.section = [coder decodeObjectForKey:@"section"];
    self.authors = [[coder decodeObjectForKey:@"authors"] copy];
    self.comments = [[coder decodeObjectForKey:@"comments"] copy];
    self.image = [coder decodeObjectForKey:@"image"];
    self.url = [[coder decodeObjectForKey:@"url"] copy];
    self.content = [[coder decodeObjectForKey:@"content"] copy];
    return self;
}

@end
