//
//  LoadingViewController.h
//  Felix
//
//  Created by Kunal Wagle on 30/12/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *currentSection;
@property NSArray *sections;
@property NSString *current;
@property int count;
@property BOOL loaded;
@property UIViewController *vc;
-(void)update;

@end
