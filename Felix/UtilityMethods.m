//
//  UtilityMethods.m
//  Felix
//
//  Created by Kunal Wagle on 27/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "UtilityMethods.h"

#import "Article.h"
#import "User.h"

@implementation UtilityMethods

+(NSMutableArray*)getArticles:(NSString*)section {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", section]];
    NSMutableArray *a = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    if (!a) {
        [UtilityMethods loadArticles:section];
    }
    return a;
}

+(void)loadArticles:(NSString*)section {
    NSMutableArray *articles = [UtilityMethods setUpArticles:section];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", section]];
    NSMutableArray *a = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    for (int i=0; i<[a count]; i++) {
        [articles addObject:a];
    }
    BOOL success = [NSKeyedArchiver archiveRootObject:articles toFile:dataPath];
    NSLog(@" %s", success ? "true" : "false");
}

+(NSMutableArray*)setUpArticles:(NSString*)section {
    NSString *restCallString = [NSString stringWithFormat:@"http://felixonline.co.uk/api/articles/"];
    if (![section isEqualToString:@"Home"]) {
        restCallString = [restCallString stringByAppendingString:[section lowercaseString]];
    } else {
        restCallString = [restCallString stringByAppendingString:@"news"];
    }
    NSLog(@"Started Request");
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:restCallString]];
    /* set headers, etc. on request if needed */
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData: response options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"Got response");
    NSMutableArray *articles = [[NSMutableArray alloc] initWithObjects:nil];
    for (int i=0; i<[array count]; i++) {
        NSLog(@"%d start", i);
        NSDictionary *dict = [array objectAtIndex:i];
        int aid = [[dict objectForKey:@"id"] intValue];
        NSString* title = [dict objectForKey:@"title"];
        NSString* teaser = [dict objectForKey:@"teaser"];
        NSString* content = [dict objectForKey:@"content"];
        NSString* url = [dict objectForKey:@"url"];
        //NSString* comments = [dict objectForKey:@"comments"];
        NSMutableArray* authors = [self createUser:[dict objectForKey:@"authors"]];
        Section* sect = [self createSection:[dict objectForKey:@"category"]];
        NSDictionary *img = [dict objectForKey:@"image"];
        Image* image = [self createImage:img];
        int date = [[dict objectForKey:@"date"] intValue];
        int published = [[dict objectForKey:@"published"] intValue];
        int comment_count = [[dict objectForKey:@"comment_count"] intValue];
        Article *article = [[Article alloc] initFull:aid title:title teaser:teaser content:content url:url authors:authors comments:nil section:sect image:image date:date published:published comment_count:comment_count];
        [articles addObject:article];
        NSLog(@"%d end", i);
    }
    return articles;
}

+(Image*)createImage:(NSDictionary*)image {
    if (image == [NSNull null]) {
        return NULL;
    } else {
    int iid = [[image objectForKey:@"id"] intValue];
    NSString *title = [image objectForKey:@"title"];
    NSString *url = [image objectForKey:@"url"];
    NSString *fileName = [image objectForKey:@"fileName"];
    NSString *desc = [image objectForKey:@"desc"];
    NSString *caption = [image objectForKey:@"caption"];
    NSString *attribution = [image objectForKey:@"attribution"];
    NSString *attrlink = [image objectForKey:@"attrlink"];
    int timeStamp = [[image objectForKey:@"timeStamp"] intValue];
    int width = [[image objectForKey:@"width"] intValue];
    int height = [[image objectForKey:@"height"] intValue];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:url]];
    UIImage *img = [UIImage imageWithData:imageData];
    Image *result = [[Image alloc] initFull:iid title:title url:url fileName:fileName desc:desc timeStamp:timeStamp caption:caption attribution:attribution attr_link:attrlink width:width height:height image:img];
    return result;
    }
    return NULL;
}

+(Section*)createSection:(NSDictionary*)section {
    if (section == [NSNull null]) {
        return NULL;
    }
    int sid = [[section objectForKey:@"id"] intValue];
    NSString *label = [section objectForKey:@"label"];
    NSString *cat = [section objectForKey:@"cat"];
    NSString *email = [section objectForKey:@"section"];
    NSString *twitter = [section objectForKey:@"twitter"];
    NSMutableArray *users = [self createUser:[section objectForKey:@"editors"]];
    Section *result = [[Section alloc] initFull:sid label:label cat:cat email:email twitter:twitter users:users];
    return result;
}

+(NSMutableArray*)createUser:(NSArray*)u {
    if (u == NULL) {
        return NULL;
    }
    NSMutableArray *result = [[NSMutableArray alloc] initWithObjects:nil];
    for (int i = 0; i<[u count]; i++) {
        NSDictionary* user = [u objectAtIndex:i];
        NSString *use = [user objectForKey:@"user"];
        NSString *name = [user objectForKey:@"name"];
        NSString *info = [user objectForKey:@"info"];
        NSString *desc = [user objectForKey:@"desc"];
        NSString *email = [user objectForKey:@"email"];
        NSString *facebook = [user objectForKey:@"facebook"];
        NSString *twitter = [user objectForKey:@"twitter"];
        NSString *websitename = [user objectForKey:@"websitename"];
        NSString *websiteurl = [user objectForKey:@"websiteurl"];
        Image *img = [UtilityMethods createImage:[user objectForKey:@"img"]];
        User *res = [[User alloc] initFull:use name:name info:info email:email twitter:twitter desc:desc facebook:facebook websitename:websitename websiteurl:websiteurl img:img];
        [result addObject:res];
    }
    return result;
}

@end
