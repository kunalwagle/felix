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

@interface articleTableViewController ()

@end

@implementation articleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpArticles];
    FLXAppDelegate *appDel = (FLXAppDelegate*) [UIApplication sharedApplication].delegate;
    appDel.articleTableVC = self;
    NSString* section = appDel.section;
    NSArray *articles = [UtilityMethods getArticles:section];
    self.articleTitles = [[NSMutableArray alloc] initWithObjects: nil];
    self.articleImages = [[NSMutableArray alloc] initWithObjects: nil];
    for (int i=3; i<[articles count]; i++) {
        Article *a = [articles objectAtIndex:i];
        NSString *title = a.getTitle;
        UIImage *image = a.getImage.getImage;
        [self.articleTitles addObject:title];
        if (image != NULL) {
            [self.articleImages addObject:image];
        } else {
            [self.articleImages addObject:[UIImage imageNamed:@"FelixLogo.png"]];
        }
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    ArticleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ArticleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.articleHeadline.text = [self.articleTitles objectAtIndex:[indexPath row]];
    cell.articleImage.image = [self.articleImages objectAtIndex:[indexPath row]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
