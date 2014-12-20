//
//  WebViewController.h
//  Felix
//
//  Created by Kunal Wagle on 16/09/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property UIWebView *webView;
- (IBAction)home:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stop;
- (IBAction)refresh:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForward;

@end
