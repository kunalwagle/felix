//
//  SplashScreenViewController.m
//  Felix
//
//  Created by Kunal Wagle on 27/11/2013.
//  Copyright (c) 2013 Felix. All rights reserved.
//

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#import "SplashScreenViewController.h"
#import "FLXViewController.h"
#import "Reachability.h"
//#import "Scringo/Scringo.h"

@interface SplashScreenViewController () {
    Reachability *internetReachableFoo;
}

@end

@implementation SplashScreenViewController

@synthesize loadingLabel;
@synthesize loadingProgress;
@synthesize catButton;

NSMutableArray *allTitles;
NSMutableArray *allImages;
NSMutableArray *allNumbers;
NSString *Section;
int Limit;

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

-(void)myCommandClicked:(NSNotification *)aNotification {
    NSLog(@"User selected my custom command. Command id is =%@", [aNotification userInfo]);
    NSDictionary *sectionTitle = [aNotification userInfo];
    Section = sectionTitle[@"customButtonId"];
  //  [self performSegueWithIdentifier:@"displayHomePage" sender:self];
  //  [Scringo closeSidebar];
    // The rest of your code
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
    [super viewDidLoad];
    allNumbers = [[NSMutableArray alloc] initWithObjects:nil];
 //   [Scringo disableSwipeToOpenSidebar];
 //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myCommandClicked:) name:kScringoCustomButtonClicked  object:nil];
    loadingProgress.progress=0;
    catButton.enabled=YES;
    loadingLabel.text = @"Click on the Cat to launch Felix";
    Section = @"TopStories";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadFelix:(id)sender {
    if ([self testInternetConnection]) {
  //  catButton.enabled=NO;
    //loadingLabel.text=@"Felix is loading";
    [self performSelectorInBackground:@selector(loading) withObject:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Felix requires an internet connection to work. Please connect to Wi-fi or turn Cellular Data on." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView setAlertViewStyle:UIAlertViewStyleDefault];
        [alertView show];
    }
    [self performSelector:@selector(openWebPage) withObject:nil afterDelay:0.01];
    
}


-(void)openWebPage {
    NSURL *url = [NSURL URLWithString:@"http://www.felixonline.co.uk"];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
    NSLog(@"Opening Web Page");
}

- (void)loading {
//    NSString *restCallString = [NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/53143730/Limit.txt"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
//                                                          URLWithString:restCallString]];
//    /* set headers, etc. on request if needed */
//    NSData *response = [NSURLConnection sendSynchronousRequest:request
//                                             returningResponse:nil error:nil];
//    NSString *html = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//    html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    allTitles = [[NSMutableArray alloc] initWithObjects: nil];
//    allImages = [[NSMutableArray alloc] initWithObjects: nil];
//    int j = [html intValue];
//    Limit = j;
//    float progressFactor = 1.0/50;
//    for (int i=j-50; i<j; ++i) {
//        restCallString = [NSString stringWithFormat:@"http://api.felixonline.co.uk/?key=69fe3c6e09f85e0e20efc1c54081df9f&what=article&id="];
//        [allNumbers addObject:[NSNumber numberWithInt:i]];
//        NSLog([NSString stringWithFormat:@"%d", i]);
//        restCallString = [restCallString stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
//        request = [NSURLRequest requestWithURL:[NSURL
//                                                URLWithString:restCallString]];
//        /* set headers, etc. on request if needed */
//        response = [NSURLConnection sendSynchronousRequest:request
//                                         returningResponse:nil error:nil];
//        html = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//        NSError *error;
//        NSDictionary *allCourses = [NSJSONSerialization
//                                    JSONObjectWithData:response
//                                    options:NSJSONReadingMutableContainers
//                                    error:&error];
//        [allTitles addObject:allCourses[@"article_title"]];
//        [allImages addObject:allCourses[@"article_image_id"]];
//        [self performSelectorOnMainThread:@selector(updateProgress) withObject:nil waitUntilDone:NO];
//    }
//    if (IS_IPHONE_5) {
//       [self performSegueWithIdentifier:@"displayHomePage" sender:self];
//    }
//    else
//    {
//        [self performSegueWithIdentifier:@"displaySmallHomePage" sender:self];
//    }
    

}

- (void) updateProgress {
    float progressFactor = 0.02;
    loadingProgress.progress = loadingProgress.progress+progressFactor;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"displayHomePage"]) {
//        FLXViewController *controller = (FLXViewController *)segue.destinationViewController;
//        controller.allTitles = allTitles;
//        controller.Array = [[NSMutableArray alloc] initWithObjects: nil];
//        controller.Teaser = [[NSMutableArray alloc] initWithObjects: nil];
//        controller.initialiseApp = YES;
//        controller.Section = Section;
//        controller.allImages = allImages;
//        controller.allNumbers = allNumbers;
        
    }
    if ([segue.identifier isEqualToString:@"displaySmallHomePage"]) {
        FLXViewController *controller = (FLXViewController *)segue.destinationViewController;
        controller.allTitles = allTitles;
        controller.Array = [[NSMutableArray alloc] initWithObjects: nil];
        controller.Teaser = [[NSMutableArray alloc] initWithObjects: nil];
        controller.initialiseApp = YES;
        controller.Section = Section;
        controller.allImages = allImages;
        controller.allNumbers = allNumbers;
        
    }
}

@end
