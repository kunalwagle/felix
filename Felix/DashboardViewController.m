//
//  DashboardViewController.m
//  Felix
//
//  Created by Kunal Wagle on 21/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "DashboardViewController.h"

#import "SWRevealViewController.h"
#import "Article.h"
#import "Image.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.section==NULL) {
        self.section = @"Home";
    }
    self.navItem.title = self.section;
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self setUpArticles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSMutableArray*)setUpArticles {
    NSString *restCallString = [NSString stringWithFormat:@"https://felixonline.co.uk/api/articles/"];
    restCallString = [restCallString stringByAppendingString:[self.section lowercaseString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:restCallString]];
    /* set headers, etc. on request if needed */
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                                       returningResponse:nil error:nil];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData: response options:NSJSONReadingMutableContainers error:&error];
    NSMutableArray *articles = [[NSMutableArray alloc] initWithObjects:nil];
    for (int i=0; i<[array count]; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        int aid = [[dict objectForKey:@"id"] intValue];
        NSString* title = [dict objectForKey:@"title"];
        NSString* teaser = [dict objectForKey:@"teaser"];
        NSString* content = [dict objectForKey:@"content"];
        NSString* url = [dict objectForKey:@"url"];
        //NSString* comments = [dict objectForKey:@"comments"];
        //NSMutableArray* authors = [self createAuthors:[dict objectForKey:@"authors"]];
        //Section* section = [self createSection:[dict objectForKey:@"category"]];
        Image* image = [self createImage:[dict objectForKey:@"image"]];
        int date = [[dict objectForKey:@"date"] intValue];
        int published = [[dict objectForKey:@"published"] intValue];
        int comment_count = [[dict objectForKey:@"comment_count"] intValue];
        Article *article = [[Article alloc] initFull:aid title:title teaser:teaser content:content url:url authors:nil comments:nil section:nil image:image date:date published:published comment_count:comment_count];
        [articles addObject:article];
    }
    return articles;
}

-(Image*)createImage:(NSDictionary*)image {
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
