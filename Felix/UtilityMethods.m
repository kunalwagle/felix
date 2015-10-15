//
//  UtilityMethods.m
//  Felix
//
//  Created by Kunal Wagle on 27/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "UtilityMethods.h"

#import <UIKit/UIKit.h>

#import "Article.h"
#import "User.h"
#import "Reachability.h"

@implementation UtilityMethods

+ (BOOL)testInternetConnection
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    } else {
        NSLog(@"We have the internet");
        return YES;
    }
}

+(NSMutableArray*)getArticles:(NSString*)section {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", section]];
    NSMutableArray *a;
    while (!a) {
        a = [[NSKeyedUnarchiver unarchiveObjectWithFile:dataPath] mutableCopy];
        int i = 0;
        while (i<[a count]) {
            @try {
                Article *art = a[i];
                NSString *title = art.getTitle;
            }
            @catch (NSException *e) {
                NSMutableArray *b = [a[i] copy];
                for (int j=0; j<[b count]; j++) {
                    [a addObject:b[j]];
                }
                [a removeObjectAtIndex:i];
                i--;
                NSLog([NSString stringWithFormat:@"We rewrote the file. The section is %@", section]);
            }
            @finally{}
            i++;
        }
        a = [UtilityMethods removeDuplicates:a];
        [NSKeyedArchiver archiveRootObject:a toFile:dataPath];
        int j=-1;
        Article *article;
//        while (j<[a count]) {
//            @try{
//                j++;
//                article = a[j];
//                NSString *title = article.getTitle;
//            }
//            @catch (NSException *e) {
//                [a removeObject:article];
//                j--;
//            }
//            @finally {
//            }
//        }
        if (!a) {
            [UtilityMethods loadArticles:section];
        }
    }
    return a;
}

+(NSMutableArray*)getArticlesWithoutRefreshing:(NSString*)section {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", section]];
    NSMutableArray *a;
        a = [[NSKeyedUnarchiver unarchiveObjectWithFile:dataPath] mutableCopy];
        int i = 0;
        while (i<[a count]) {
            @try {
                Article *art = a[i];
                NSString *title = art.getTitle;
            }
            @catch (NSException *e) {
                NSMutableArray *b = [a[i] copy];
                for (int j=0; j<[b count]; j++) {
                    [a addObject:b[j]];
                }
                [a removeObjectAtIndex:i];
                i--;
                NSLog([NSString stringWithFormat:@"We rewrote the file. The section is %@", section]);
            }
            @finally{}
            i++;
        }
        a = [UtilityMethods removeDuplicates:a];
        [NSKeyedArchiver archiveRootObject:a toFile:dataPath];
    return a;
}

+(NSMutableArray*)removeDuplicates:(NSMutableArray*)a {
//    int j=0;
//    while (j<[a count]) {
//        int i = j+1;
//            @try {
//                Article* article = a[j];
//                int comparison = article.getId;
//                while (i<[a count]) {
//                    @try {
//                        Article* comp = a[i];
//                        int c = comp.getId;
//                        if (c == comparison) {
//                            [a removeObjectAtIndex:i];
//                        }
//                        i++;
//                    }
//                    @catch (NSException *exception) {
//                    }
//                    @finally {
//                    }
//                }
//            }
//            @catch (NSException *exception) {
//            }
//            @finally {
//            }
//        j++;
//    }
//
    NSMutableSet *seenObjects = [NSMutableSet set];
    NSPredicate *dupPred = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
        Article *hObj = (Article*)obj;
        BOOL seen = [seenObjects containsObject:hObj.getTitle];
        if (!seen) {
            [seenObjects addObject:hObj.getTitle];
        }
        return !seen;
    }];
    //NSArray *yourHistoryArray = ... // This is your array which needs to be filtered
    NSArray *yourHistoryArray = [a filteredArrayUsingPredicate:dupPred];
    return yourHistoryArray;
}

+(void)loadArticles:(NSString*)section {
    NSMutableArray *articles = [UtilityMethods setUpArticles:section];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", section]];
    NSMutableArray *a = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    if ([a count]>0) {
        Article *comparison = a[0];
        for (int i=([articles count]-1); i>=0; i--) {
            Article *downloaded = [articles objectAtIndex:i];
            if (downloaded.getId<comparison.getId) {
                [articles removeObject:downloaded];
            }
        }
    }

    for (int i=0; i<[a count]; i++) {
        @try{
        Article *article= (Article*)a[i];
        int aid = article.getId;
        [articles addObject:a];
        }
        @catch (NSException* e) {
        }
        @finally {
        }
    }
    BOOL success = [NSKeyedArchiver archiveRootObject:articles toFile:dataPath];
    NSLog(@" %s", success ? "true" : "false");
}

+(NSMutableArray*)setUpArticles:(NSString*)section {
    if ([UtilityMethods testInternetConnection]) {
    NSString *restCallString = [NSString stringWithFormat:@"http://felixonline.co.uk/api/articles/"];
    if (![section isEqualToString:@"Home"]) {
        restCallString = [restCallString stringByAppendingString:[section lowercaseString]];
    } else {
        restCallString = [restCallString stringByAppendingString:@"news"];
    }
    NSLog([NSString stringWithFormat:@"Started Request: %@", section]);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:restCallString]];
    /* set headers, etc. on request if needed */
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData: response options:NSJSONReadingMutableContainers error:&error];
    NSLog([NSString stringWithFormat:@"Got Response: %@", section]);
    NSMutableArray *articles = [[NSMutableArray alloc] initWithObjects:nil];
    Section* sect;
    for (int i=0; i<[array count]; i++) {
        NSLog(@"%d start", i);
        NSDictionary *dict = [array objectAtIndex:i];
        int aid = [[dict objectForKey:@"id"] intValue];
        NSString* title = [dict objectForKey:@"title"];
        NSString* teaser = [dict objectForKey:@"teaser"];
        NSDictionary* cont = [dict objectForKey:@"content"];
        NSString* content = [cont objectForKey:@"value"];
        NSString* url = [dict objectForKey:@"url"];
        //NSString* comments = [dict objectForKey:@"comments"];
        NSMutableArray* authors = [self createUser:[dict objectForKey:@"authors"]];
        if (i==0) {
            sect = [self createSection:[dict objectForKey:@"category"]];
        }
        NSDictionary *img = [dict objectForKey:@"image"];
        Image* image = [self createImage:img];
        //int date = [[dict objectForKey:@"date"] intValue];
        //int published = [[dict objectForKey:@"published"] intValue];
        //int comment_count = [[dict objectForKey:@"comment_count"] intValue];
        Article *article = [[Article alloc] initFull:aid title:title teaser:teaser content:content url:url authors:authors comments:nil section:sect image:image date:0 published:0 comment_count:0];
        [articles addObject:article];
        NSLog(@"%d end", i);
    }
    return articles;
    }
    return [[NSMutableArray alloc] initWithObjects: nil];
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
    Image *result = [[Image alloc] initFull:iid title:title url:url fileName:fileName desc:desc timeStamp:timeStamp caption:caption attribution:attribution attr_link:attrlink width:width height:height];
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
        NSString *desc = [user objectForKey:@"description"];
        NSString *email = [user objectForKey:@"email"];
        NSString *facebook = [user objectForKey:@"facebook"];
        NSString *twitter = [user objectForKey:@"twitter"];
        NSString *websitename = [user objectForKey:@"websitename"];
        NSString *websiteurl = [user objectForKey:@"websiteurl"];
        NSDictionary *image = [user objectForKey:@"image"];
        Image* img = [self createImage:image];
        User *res = [[User alloc] initFull:use name:name info:info email:email twitter:twitter desc:desc facebook:facebook websitename:websitename websiteurl:websiteurl img:img];
        [result addObject:res];
    }
    return result;
}

+(NSMutableDictionary*)setColours:(NSMutableDictionary*)dict {
    UIColor *colour = [[UIColor alloc] initWithRed:234.0/255.0 green:204.0/255.0 blue:207.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"home"];
    [dict setObject:colour forKey:@"news"];
    colour = [[UIColor alloc] initWithRed:197.0/255.0 green:216.0/255.0 blue:219.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"comment"];
    colour = [[UIColor alloc] initWithRed:234.0/255.0 green:204.0/255.0 blue:212.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"features"];
    colour = [[UIColor alloc] initWithRed:215.0/255.0 green:232.0/255.0 blue:213.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"science"];
    colour = [[UIColor alloc] initWithRed:250.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"politics"];
    colour = [[UIColor alloc] initWithRed:222.0/255.0 green:203.0/255.0 blue:190.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"arts"];
    colour = [[UIColor alloc] initWithRed:204.0/255.0 green:219.0/255.0 blue:212.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"music"];
    colour = [[UIColor alloc] initWithRed:209.0/255.0 green:225.0/255.0 blue:228.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"film"];
    colour = [[UIColor alloc] initWithRed:218.0/255.0 green:209.0/255.0 blue:223.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"fashion"];
    colour = [[UIColor alloc] initWithRed:223.0/255.0 green:200.0/255.0 blue:190.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"games"];
    colour = [[UIColor alloc] initWithRed:178.0/255.0 green:204.0/255.0 blue:228.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"tech"];
    colour = [[UIColor alloc] initWithRed:204.0/255.0 green:233.0/255.0 blue:235.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"travel"];
    colour = [[UIColor alloc] initWithRed:225.0/255.0 green:206.0/255.0 blue:194.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"food"];
    colour = [[UIColor alloc] initWithRed:208.0/255.0 green:211.0/255.0 blue:218.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"tv"];
    colour = [[UIColor alloc] initWithRed:225.0/255.0 green:204.0/255.0 blue:216.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"books"];
    colour = [[UIColor alloc] initWithRed:195.0/255.0 green:210.0/255.0 blue:237.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"welfare"];
    colour = [[UIColor alloc] initWithRed:213.0/255.0 green:242.0/255.0 blue:235.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"cands"];
    colour = [[UIColor alloc] initWithRed:216.0/255.0 green:222.0/255.0 blue:217.0/255.0 alpha:1];
    [dict setObject:colour forKey:@"sport"];
    return dict;
}

@end
