//
//  articleTableViewController.m
//  Felix
//
//  Created by Kunal Wagle on 22/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "articleTableViewController.h"
#import "ArticleViewCell.h"
#import "UtilityMethods.h"
#import "Article.h"
#import "FLXAppDelegate.h"
#import "LoadingViewController.h"

@interface articleTableViewController ()

@end

@implementation articleTableViewController

NSString *string2 = @".co.uk/112/74/";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpArticles];
    FLXAppDelegate *appDel = (FLXAppDelegate*) [UIApplication sharedApplication].delegate;
    appDel.articleTableVC = self;
    NSString* section = appDel.section;
    self.section = appDel.section;
    self.articles = [UtilityMethods getArticles:section];
    self.articleTitles = [[NSMutableArray alloc] initWithObjects: nil];
    self.articleImages = [[NSMutableArray alloc] initWithObjects: nil];
    self.articleUrl = [[NSMutableArray alloc] initWithObjects: nil];
    for (int i=3; i<[self.articles count]; i++) {
        Article *a = [self.articles objectAtIndex:i];
        @try {
        NSString *title = a.getTitle;
        if (a.getImage.getUrl != NULL) {
            [self.articleUrl addObject:a.getImage.getUrl];
        } else {
            [self.articleUrl addObject:@""];
        }
       // UIImage *image = a.getImage.getImage;
        [self.articleTitles addObject:title];
//        if (image != NULL) {
//            [self.articleImages addObject:image];
//        } else {
            [self.articleImages addObject:[UIImage imageNamed:@"FelixLogo.png"]];
       // }
        }
        @catch (NSException *e) {}
        @finally{}
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshAll)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)refreshAll {
//    LoadingViewController *loadingViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"loadingPage"];
//    loadingViewController.loaded = YES;
//    loadingViewController.vc = self;
//    //[self addChildViewController:loadingViewController];
//    [self presentViewController:loadingViewController animated:YES completion:nil];
    if (self.refreshControl) {
        NSString *title = @"Refreshing";
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
    }
    if ([UtilityMethods testInternetConnection]) {
        FLXAppDelegate *appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *section = [appDel section];
        dispatch_queue_t imageQueue = dispatch_queue_create("Image Queue",NULL);
        dispatch_async(imageQueue, ^{
            [UtilityMethods loadArticles:section];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                [self performSelectorOnMainThread:@selector(reload) withObject:nil waitUntilDone:YES];
            });
            
        });

    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"You don't seem to be connected to the internet. Please connect to the internet and try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:100];
        [alert show];
    }
}

-(void)reload{
    FLXAppDelegate *appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *loadedBottom = [appDel loadedBottom];
    [loadedBottom removeAllObjects];
    [[appDel loadedTop] removeAllObjects];
    NSLog(@"NOW");
    [self.refreshControl endRefreshing];
    [appDel.pageContainerViewController reloadData:appDel.section];
    [self viewDidLoad];
    [self.tableView reloadData];
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
    }

}

-(void)reloadData:(NSString*) section {
//    NSArray *articles = [UtilityMethods getArticles:section];
//    self.articleTitles = [[NSMutableArray alloc] initWithObjects: nil];
//    self.articleImages = [[NSMutableArray alloc] initWithObjects: nil];
//    for (int i=3; i<[articles count]; i++) {
//        Article *a = [articles objectAtIndex:i];
//        NSString *title = a.getTitle;
//        UIImage *image = a.getImage.getImage;
//        [self.articleTitles addObject:title];
//        if (image != NULL) {
//            [self.articleImages addObject:image];
//        } else {
//            [self.articleImages addObject:[UIImage imageNamed:@"FelixLogo.png"]];
//        }
//        
//    }
//    [self.tableView reloadData];
    //self.section = section;
}

- (void)setUpArticles {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.articleTitles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLXAppDelegate *appDelegate = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *loaded = appDelegate.loadedBottom;
    ArticleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ArticleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.articleHeadline.editable = YES;
    cell.articleHeadline.font = [UIFont fontWithName:@"NotoSerif" size:14];
    cell.articleHeadline.editable = NO;
    cell.articleHeadline.text = [self.articleTitles objectAtIndex:[indexPath row]];
    cell.articleImage.image = [self.articleImages objectAtIndex:[indexPath row]];
    if ([loaded objectForKey:[NSString stringWithFormat:@"%ld", [indexPath row]]]) {
        cell.articleImage.image = [loaded objectForKey:[NSString stringWithFormat:@"%ld", [indexPath row]]];
        return cell;
    }
    if (![[self.articleUrl objectAtIndex:[indexPath row]] isEqualToString:@""]) {
        if ([UtilityMethods testInternetConnection]) {
        dispatch_queue_t imageQueue = dispatch_queue_create("Image Queue",NULL);
        NSLog(@"Hello");
        dispatch_async(imageQueue, ^{
            NSString *string3 = [self.articleUrl objectAtIndex:[indexPath row]];
            int width = cell.articleImage.bounds.size.width;
            int height = cell.articleImage.bounds.size.height;
            NSString *string = [NSString stringWithFormat:@".co.uk/%d/%d/", width, height];
            string3 = [string3 stringByReplacingOccurrencesOfString:@".co.uk/upload" withString:string];
            NSURL *url = [NSURL URLWithString:string3];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            NSLog(@"There");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
               // [cell.articleImage setImage:image];
                //self.loaded = YES;
                if (image && [appDelegate.section isEqualToString:self.section]) {
                    [loaded setObject:image forKey:[NSString stringWithFormat:@"%ld", [indexPath row]]];
                    [tableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
                }
                NSLog(@"Set the image");
            });
            
        });
        }
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"articleSegue"]) {
        FLXAppDelegate *appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
        int index = [[self.tableView indexPathForSelectedRow] row];
        appDel.article = self.articles[index+3];
        RightSidebarViewController *rightSidebar = appDel.rightSidebar;
        [rightSidebar reloadAllData:appDel.article.getSection author:appDel.article.getAuthors];
    }
}


@end
