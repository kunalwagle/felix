//
//  SplashScreenViewController.h
//  Felix
//
//  Created by Kunal Wagle on 27/11/2013.
//  Copyright (c) 2013 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIProgressView *loadingProgress;
@property (weak, nonatomic) IBOutlet UIButton *catButton;
- (IBAction)loadFelix:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@end
