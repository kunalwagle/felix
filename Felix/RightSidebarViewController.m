//
//  RightSidebarViewController.m
//  Felix
//
//  Created by Kunal Wagle on 26/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "RightSidebarViewController.h"
#import "User.h"
#import "FLXAppDelegate.h"

@interface RightSidebarViewController ()

@end

@implementation RightSidebarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FLXAppDelegate *appDel = (FLXAppDelegate*) [UIApplication sharedApplication].delegate;
    appDel.rightSidebar = self;
    Article* article = appDel.article;
    Section *section = article.getSection;
    [self reloadAllData:section author:NULL];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

-(void)reloadAllData:(Section*)section author:(NSMutableArray*)author {
    self.section = section.getUser;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1 + ([self.section count]>0) + ([self.author count]>0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            if ([self.section count]>0) {
                return [self.section count];
            } else {
                if ([self.author count]>0) {
                    return [self.author count];
                } else {
                    return 2;
                }
            }
        case 1:
            if ([self.section count] > 0) {
                if ([self.author count]>0) {
                    return [self.author count];
                } else {
                    return 2;
                }
            } else {
                return 2;
            }
        case 2:
            return 2;
                
        default:
            break;
    }
    return 0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            if ([self.section count]>0) {
                return @"Section Editors";
            } else {
                if ([self.author count]>0) {
                    return @"Authors";
                } else {
                    return @"Find a PDF";
                }
            }
        case 1:
            if ([self.section count] > 0) {
                if ([self.author count]>0) {
                    return @"Authors";
                } else {
                    return @"Find a PDF";
                }
            } else {
                return @"Find a PDF";
            }
        case 2:
            return @"Find a PDF";
    }
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x+60, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height)];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier;
    switch ([indexPath section]) {
        case 0:
            if ([self.section count]>0 || [self.author count]>0) {
                CellIdentifier = @"user";
            } else {
                CellIdentifier = @"issue";
            }
            break;
        case 1:
            if ([self.section count]>0 && [self.author count]>0) {
                CellIdentifier = @"user";
            } else {
                CellIdentifier = @"issue";
            }
            break;
        case 2:
            CellIdentifier = @"issue";
            break;
        default:
            break;
    }
    if ([CellIdentifier isEqualToString:@"issue"]) {
        if ([indexPath row]==0) {
            CellIdentifier = @"latest";
        } else {
            CellIdentifier = @"archive";
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if ([CellIdentifier isEqualToString:@"user"]) {
        if ([self.section count]>0 && [indexPath section]==0) {
            cell.textLabel.text = [[self.section objectAtIndex:[indexPath row]] getName];
        } else {
            cell.textLabel.text = [[self.author objectAtIndex:[indexPath row]] getName];
        }
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
