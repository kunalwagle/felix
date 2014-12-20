//
//  WebViewController.m
//  Felix
//
//  Created by Kunal Wagle on 16/09/2014.
//  Copyright (c) 2014 Felix. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

bool link2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setUpWebPage {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, 320, 500)];
    self.webView.delegate = self;
    self.webView.hidden = NO;
    NSString *fullURL = @"http://felixonline.co.uk";
    NSURL *url = [NSURL URLWithString:fullURL];
    [self.view addSubview:self.webView];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    [self.webView setScalesPageToFit:YES];
    [self.activityIndicator setHidden:NO];
    [self.webView setAlpha:0.3];
}

- (void)viewDidLoad
{
//   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"In View Did Load" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert setHidden:YES];
//    [alert show];
//    [alert dismissWithClickedButtonIndex:-1 animated:NO];

    [self performSelector:@selector(setUpWebPage) withObject:nil afterDelay:0.01];
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

-(void)startingWebView {
    if (link) {
        [self.activityIndicator setHidden:NO];
        [self.webView setAlpha:0.3];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didFinishLoad {
    if ([self.webView respondsToSelector:@selector(scrollView)])
    {
        UIScrollView *scroll=[self.webView scrollView];
        
        float zoom=self.webView.bounds.size.width/scroll.contentSize.width;
        [scroll setZoomScale:zoom animated:YES];
    }
    self.goBack.enabled = [self.webView canGoBack];
    self.goForward.enabled = [self.webView canGoForward];
    self.stop.enabled = NO;
    self.activityIndicator.hidden = YES;
    [self.webView setAlpha:1];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self performSelector:@selector(didFinishLoad) withObject:nil afterDelay:0.01];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"In DidFinishLoad" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert setHidden:YES];
//    [alert show];
//    [alert dismissWithClickedButtonIndex:-1 animated:NO];
}

- (BOOL) webView: (UIWebView*) webView
shouldStartLoadWithRequest: (NSURLRequest*) request
  navigationType: (UIWebViewNavigationType) navigationType
{
    link2 = navigationType == UIWebViewNavigationTypeLinkClicked;
    [self performSelector:@selector(startingWebView) withObject:nil afterDelay:0.01];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"In shouldStartLoad" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert setAlpha:0];
//    [alert show];
//    [alert dismissWithClickedButtonIndex:-1 animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)home:(id)sender {
    NSString *fullURL = @"http://felixonline.co.uk";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    [self.stop setEnabled:YES];
    [self.activityIndicator setHidden:NO];
    [self.webView setAlpha:0.3];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
    [self.stop setEnabled:YES];
    [self.activityIndicator setHidden:NO];
    [self.webView setAlpha:0.3];
}

- (IBAction)stop:(id)sender {
    [self.webView stopLoading];
    [self.stop setEnabled:NO];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
    [self.stop setEnabled:YES];
    [self.activityIndicator setHidden:NO];
    [self.webView setAlpha:0.3];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
    [self.stop setEnabled:YES];
    [self.activityIndicator setHidden:NO];
    [self.webView setAlpha:0.3];
}
@end
