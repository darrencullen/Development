//
//  WebViewController.h
//  DublinCityParking
//
//  Created by darren cullen on 16/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *webViewTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;

- (IBAction)refreshPage:(id)sender;
- (IBAction)backButtonPressed:(id)sender;


@end
