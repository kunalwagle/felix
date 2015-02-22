//
//  FLXViewController.m
//  Felix
//
//  Created by Kunal Wagle on 26/11/2013.
//  Copyright (c) 2013 Felix. All rights reserved.
//

#import "FLXViewController.h"
#import "ArticleViewController.h"
//#import <Scringo/Scringo.h>
//#import "Reachability.h"

@interface FLXViewController () {
 //   Reachability *internetReachableFoo;
}

@end

@implementation FLXViewController

@synthesize Table;
@synthesize allTitles;
@synthesize initialiseApp;
@synthesize Array;
@synthesize Teaser;
@synthesize Section;
@synthesize activityBar;
@synthesize allImages;
@synthesize allNumbers;

NSMutableArray *Names;
NSMutableArray *Image;
NSMutableArray *searchResults;
NSMutableArray *searchImages;
NSMutableArray *searchNumbers;
bool Search = NO;
int Number;
NSString *monday;

- (BOOL)testInternetConnection
{
    return YES;
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

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [allTitles filteredArrayUsingPredicate:resultPredicate];
    [searchImages removeAllObjects];
    for (int i=0; i<[searchResults count]; ++i) {
        id someObject = searchResults[i]; // get some value
        NSUInteger originalIndex = [allTitles indexOfObject:someObject];
        [searchImages addObject:[allImages objectAtIndex:originalIndex]];
        [searchNumbers addObject:[allNumbers objectAtIndex:originalIndex]];
        NSString *restCallString = [NSString stringWithFormat:@"http://api.felixonline.co.uk/?key=69fe3c6e09f85e0e20efc1c54081df9f&what=image&id="];
        restCallString = [restCallString stringByAppendingString:[searchImages objectAtIndex:i]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
                                                              URLWithString:restCallString]];
        /* set headers, etc. on request if needed */
        NSData *response = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:nil error:nil];
        NSDictionary *allCourses = [NSJSONSerialization
                                    JSONObjectWithData:response
                                    options:NSJSONReadingMutableContainers
                                    error:nil];
        monday = allCourses[@"image_url"];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:monday]];
        [searchImages replaceObjectAtIndex:i withObject:[UIImage imageWithData:imageData]];
    }
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    return NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [self filterContentForSearchText:searchBar.text
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (void)setUpArticles {
    if ([self testInternetConnection]) {;
        Teaser = [[NSMutableArray alloc] initWithObjects: nil];
        Array = [[NSMutableArray alloc] initWithObjects:nil];
        Image = [[NSMutableArray alloc] initWithObjects: nil];
        NSString *restCallString = [NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/53143730/"];
        restCallString = [restCallString stringByAppendingString:Section];
        restCallString = [restCallString stringByAppendingString:@".txt"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
                                                              URLWithString:restCallString]];
        /* set headers, etc. on request if needed */
        NSData *response = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:nil error:nil];
        NSString *html = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        Names = [html componentsSeparatedByString:@"\r"];
        for (int i=0; i<[Names count]; ++i) {
            restCallString = [NSString stringWithFormat:@"http://api.felixonline.co.uk/?key=69fe3c6e09f85e0e20efc1c54081df9f&what=article&id="];
            restCallString = [restCallString stringByAppendingString:[Names objectAtIndex:i]];
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
            monday = allCourses[@"article_title"];
            [self stringByStrippingHTML];
            [Array addObject:monday];
            monday = allCourses[@"article_teaser"];
            [self stringByStrippingHTML];
            [Teaser addObject:monday];
            monday = allCourses[@"article_image_id"];
            restCallString = [NSString stringWithFormat:@"http://api.felixonline.co.uk/?key=69fe3c6e09f85e0e20efc1c54081df9f&what=image&id="];
            restCallString = [restCallString stringByAppendingString:monday];
            request = [NSURLRequest requestWithURL:[NSURL
                                                    URLWithString:restCallString]];
            /* set headers, etc. on request if needed */
            response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
            html = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            allCourses = [NSJSONSerialization
                                        JSONObjectWithData:response
                                        options:NSJSONReadingMutableContainers
                                        error:&error];
            monday = allCourses[@"image_url"];
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:monday]];
            [Image addObject:[UIImage imageWithData: imageData]];
        }
        initialiseApp = NO;
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Felix requires an internet connection to work. Please connect to Wi-fi or turn Cellular Data on." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView setAlertViewStyle:UIAlertViewStyleDefault];
        [alertView show];
    }
}

-(void)updateProgress {
    activityBar.hidden = NO;
    [activityBar startAnimating];
 //   [Scringo closeSidebar];
}

-(void)myCommandClicked:(NSNotification *)aNotification {
    NSLog(@"User selected my custom command. Command id is =%@", [aNotification userInfo]);
    Table.hidden = YES;
    [self performSelectorOnMainThread:@selector(updateProgress) withObject:nil waitUntilDone:YES];
    NSDictionary *sectionTitle = [aNotification userInfo];
    Section = sectionTitle[@"customButtonId"];
  //  [self setUpArticles];
    [Table reloadData];
    activityBar.hidden = YES;
    [activityBar stopAnimating];
    Table.hidden=NO;
    // The rest of your code
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchNumbers = [[NSMutableArray alloc] initWithObjects:nil]; 
    searchImages = [[NSMutableArray alloc] initWithObjects: nil];
//    [Scringo enableSwipeToOpenSidebar];
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myCommandClicked:) name:kScringoCustomButtonClicked  object:nil];
  //  searchResults = [[NSMutableArray alloc] initWithObjects: nil];
    if (initialiseApp) {
        [Array removeAllObjects];
        [Teaser removeAllObjects];
        [self setUpArticles];
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [Names count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    bool DontDoAgain = YES;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        DontDoAgain = NO;
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
            cell.imageView.image = [searchImages objectAtIndex:indexPath.row];
        
        
    } else {
        cell.textLabel.text = [Array objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [Teaser objectAtIndex:indexPath.row];
        cell.imageView.image=[Image objectAtIndex:indexPath.row];
    }
    
    CGSize itemSize = CGSizeMake(80, 80);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    cell.imageView.frame=CGRectMake(20, 5, 20, 20);
//    [cell.imageView.layer setMasksToBounds:YES];
//    int CurrentNumber = indexPath.row; //The current Number is assigned as the row number
//    if (CurrentNumber<[Names count]) { //If the row number is not larger than the current row.
//        //get the integer value of the number in this position in the array
//        cell.textLabel.text=Names[CurrentNumber]; //set the title of the cell to the name of the Room
//    }
    cell.detailTextLabel.numberOfLines = 4;
    NSLog(cell.textLabel.text);
        cell.textLabel.TextColor = [UIColor blackColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Number = indexPath.row; //set Number to the Row Number selected
    if (tv == self.searchDisplayController.searchResultsTableView) {
        Search = YES;
    }
    else {Search = NO;}
    [self performSegueWithIdentifier:@"displayArticle" sender:self];
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"displayArticle"]) {
        ArticleViewController *controller = (ArticleViewController *)segue.destinationViewController;
        if (Search) {
            controller.ArticleNumber = [[searchNumbers objectAtIndex:Number] intValue];
            controller.image = [searchImages objectAtIndex:Number];
        }
        else {
            controller.ArticleNumber = [Names[Number] intValue];
            controller.image = [Image objectAtIndex:Number];
        }
        controller.Articles = Array;
        controller.Teasers = Teaser;
        controller.Section = Section;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OpenCloseSidebar:(id)sender {
 //   [Scringo openSidebar];
}
@end
