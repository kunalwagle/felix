//
//  ArticleViewController.m
//  Felix
//
//  Created by Kunal Wagle on 26/11/2013.
//  Copyright (c) 2013 Felix. All rights reserved.
//

#import "ArticleViewController.h"
#import "FLXViewController.h"
//#import <Scringo/Scringo.h>
#import "Reachability.h"

@interface ArticleViewController () {
    Reachability *internetReachableFoo;
}

@end

@implementation ArticleViewController

@synthesize NavigationBar;
@synthesize Title;
@synthesize Teaser;
@synthesize Content;
@synthesize ArticleNumber;
@synthesize Author;
@synthesize aLikeButton;
@synthesize aCommentButton;
@synthesize Articles;
@synthesize Teasers;
@synthesize articleImage;
@synthesize image;
@synthesize Section;

NSString *restCallString;
NSURLRequest *request;
NSData *response;
NSString *html;
NSString *monday;
BOOL initialiseApp = NO;

-(void)myCommandClicked:(NSNotification *)aNotification {
    NSLog(@"User selected my custom command. Command id is =%@", [aNotification userInfo]);
    NSDictionary *sectionTitle = [aNotification userInfo];
    Section = sectionTitle[@"customButtonId"];
    initialiseApp = YES;
    [self performSegueWithIdentifier:@"backToMainPage" sender:self];
    // The rest of your code
}

- (BOOL)testInternetConnection
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

-(NSString *) stringByStrippingHTML {
    NSRange r;
    NSLog(monday);
    while ((r = [monday rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        monday = [monday stringByReplacingCharactersInRange:r withString:@""];
    monday = [monday stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    monday = [monday stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    monday = [monday stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    monday = [monday stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    monday = [monday stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    monday = [monday stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"-"];
    monday = [monday stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"'"];
    monday = [monday stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
    monday = [monday stringByReplacingOccurrencesOfString:@"&pound;" withString:@"£"];
    monday = [monday stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"e"];
    monday = [monday stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    monday = [monday stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
    monday = [monday stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\""];
    
    return monday;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
 //   [Scringo disableSwipeToOpenSidebar];
    initialiseApp = NO;
//    [Scringo addSidebar:self.view toLeft:YES];
    articleImage.image = image;
 //       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myCommandClicked:) name:kScringoCustomButtonClicked  object:nil];
    if ([self testInternetConnection]) {
    restCallString = [NSString stringWithFormat:@"http://api.felixonline.co.uk/?key=69fe3c6e09f85e0e20efc1c54081df9f&what=article&id="];
    restCallString = [restCallString stringByAppendingString:[NSString stringWithFormat:@"%d", ArticleNumber]];
   // [aCommentButton :restCallString withTitle:@"An Article"];
    request = [NSURLRequest requestWithURL:[NSURL
                                            URLWithString:restCallString]];
    /* set headers, etc. on request if needed */
    response = [NSURLConnection sendSynchronousRequest:request
                                     returningResponse:nil error:nil];
    html = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *allCourses = [NSJSONSerialization
                                JSONObjectWithData:response
                                options:NSJSONReadingMutableContainers
                                error:&error];
    monday = allCourses[@"article_category_display"];
    [self stringByStrippingHTML];
    NavigationBar.topItem.title = monday;
    monday = allCourses[@"article_title"];
    [self stringByStrippingHTML];
    Title.text = monday;
    [aLikeButton updateLikeObject:restCallString type:SCRINGO_APP_LIKE_IMAGE description:monday];
    monday = allCourses[@"article_teaser"];
    [self stringByStrippingHTML];
    Teaser.text = monday;
    monday = allCourses[@"article_author_full"];
    [self stringByStrippingHTML];
    Author.text = monday;
    monday = allCourses[@"article_content"];
    [self stringByStrippingHTML];
    Content.text = monday;
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Felix requires an internet connection to work. Please connect to Wi-fi or turn Cellular Data on." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView setAlertViewStyle:UIAlertViewStyleDefault];
        [alertView show];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    initialiseApp = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)ShowSidebar:(id)sender {
//    [Scringo openSidebar];
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"backToMainPage"]) {
//        FLXViewController *controller = (FLXViewController *)segue.destinationViewController;
//        controller.initialiseApp = NO;
//        if (initialiseApp) {
//            controller.initialiseApp = YES;
//        }
//        controller.Array = Articles;
//        controller.Teaser = Teasers;
//        controller.Section = Section;
//        
//    }
//}

- (IBAction)Done:(id)sender {
 //   [Scringo enableSwipeToOpenSidebar];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
