//
//  SearchViewController.m
//  Felix
//
//  Created by Kunal Wagle on 04/01/2015.
//  Copyright (c) 2015 Felix. All rights reserved.
//

#import "SearchViewController.h"
#import "FelixUtilityMethods.h"
#import "ArticleViewCell.h"
#import "Article.h"
#import "FLXAppDelegate.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.articles = [[NSMutableArray alloc] initWithObjects: nil];
    self.searchResults = [[NSMutableArray alloc] initWithObjects: nil];
    NSArray *sections = @[@"news", @"comment", @"features", @"science", @"politics", @"arts", @"music", @"film", @"fashion", @"games", @"technology", @"travel", @"food", @"tv", @"books", @"welfare", @"cands",@"sport"];
    for (NSString* section in sections) {
        [self.articles addObjectsFromArray:[FelixUtilityMethods getArticlesWithoutRefreshing:section]];
    }
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResults removeAllObjects];
    NSPredicate *resultPredicate1 = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    //[self.searchResults addObjectsFromArray:[self.articles filteredArrayUsingPredicate:resultPredicate1]];
    NSPredicate *resultPredicate2 = [NSPredicate predicateWithFormat:@"ANY authors.name contains[c] %@", searchText];
    //[self.searchResults addObjectsFromArray:[self.articles filteredArrayUsingPredicate:resultPredicate2]];
    NSPredicate *resultPredicate3 = [NSPredicate predicateWithFormat:@"ANY authors.user contains[c] %@", searchText];
    //[self.searchResults addObjectsFromArray:[self.articles filteredArrayUsingPredicate:resultPredicate3]];
    NSPredicate *resultPredicate4 = [NSPredicate predicateWithFormat:@"teaser contains[c] %@", searchText];
    //[self.searchResults addObjectsFromArray:[self.articles filteredArrayUsingPredicate:resultPredicate4]];
    NSArray *predicates = @[resultPredicate1, resultPredicate2, resultPredicate3, resultPredicate4];
    NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicates];
    [self.searchResults addObjectsFromArray:[self.articles filteredArrayUsingPredicate:compoundPredicate]];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.searchResults count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"articleSegue" sender:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 //   if (tableView == self.searchDisplayController.searchResultsTableView) {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Article *a = [self.searchResults objectAtIndex:[indexPath row]];
        cell.textLabel.font = [UIFont fontWithName:@"Neuton-Bold" size:14];
        cell.textLabel.text = [a getTitle];
//    cell.articleHeadline.editable = YES;
//    cell.articleHeadline.font = [UIFont fontWithName:@"Neuton-Bold" size:17];
//    cell.articleHeadline.editable = NO;
//    cell.articleHeadline.text = [a getTitle];
//    cell.articleImage.image = [UIImage imageNamed:@"FelixLogo.png"];
    return cell;
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

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 if ([[segue identifier] isEqualToString:@"articleSegue"]) {
 FLXAppDelegate *appDel = (FLXAppDelegate*)[[UIApplication sharedApplication] delegate];
 int index = [[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] row];
 appDel.article = self.searchResults[index];
 RightSidebarViewController *rightSidebar = appDel.rightSidebar;
 [rightSidebar reloadAllData:appDel.article.getSection author:appDel.article.getAuthors];
         [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] animated:YES];
 }
 }

- (IBAction)back:(id)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
