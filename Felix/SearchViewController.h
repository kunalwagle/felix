//
//  SearchViewController.h
//  Felix
//
//  Created by Kunal Wagle on 04/01/2015.
//  Copyright (c) 2015 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UITableViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSMutableArray *articles;
@property NSMutableArray *searchResults;
- (IBAction)back:(id)sender;

@end
