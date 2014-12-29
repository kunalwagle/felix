//
//  SidebarViewController.m
//  Felix
//
//  Created by Kunal Wagle on 24/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "SidebarViewController.h"

#import "SWRevealViewController.h"
#import "DashboardViewController.h"
#import "FLXAppDelegate.h"
#import "PageContainerViewController.h"
#import "articleTableViewController.h"

@interface SidebarViewController ()

@end

@implementation SidebarViewController

- (void)viewDidAppear:(BOOL)animated {
            [self.tableView setContentOffset:CGPointZero animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.cells = [[NSMutableArray alloc] initWithObjects:@"title", @"home", @"news", @"features", @"comment", @"science", @"politics", @"business", @"arts", @"music", @"film", @"fashion", @"games", @"tech", @"travel", @"food", @"television", @"books", @"welfare", @"clubs and socs", @"sport", nil];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
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
    return [self.cells count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [self.cells objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DashboardViewController *destViewController = (DashboardViewController*)segue.destinationViewController;
    destViewController.section = [[self.cells objectAtIndex:indexPath.row] capitalizedString];
    FLXAppDelegate *appDel = (FLXAppDelegate*) [UIApplication sharedApplication].delegate;
    appDel.section = [self.cells objectAtIndex:indexPath.row];
//    PageContainerViewController *pcvc = appDel.pageContainerViewController;
//    articleTableViewController *atvc = appDel.articleTableVC;
//    [pcvc reloadData:[self.cells objectAtIndex:indexPath.row]];
//    [atvc reloadData:[self.cells objectAtIndex:indexPath.row]];
//    
    //destViewController.title = [[self.cells objectAtIndex:indexPath.row] capitalizedString];

    if ( [segue isKindOfClass: [SWRevealViewControllerSeguePushController class]] ) {
//        SWRevealViewControllerSeguePushController *swSegue = (SWRevealViewControllerSeguePushController*) segue;
//        
//        //swSegue.performBlock = ^(SWRevealViewControllerSeguePushController* rvc_segue, UIViewController* svc, UIViewController* dvc) {
//            
//            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
//            [navController setViewControllers: @[destViewController] animated: NO ];
//            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
////       // };
//        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.revealViewController.frontViewController];
//        [self.revealViewController pushFrontViewController:destViewController animated:YES];
//        
    }
    
}


@end
