//
//  TrafficCameraImageViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 13/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "TrafficCameraImageViewController.h"

@interface TrafficCameraImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinner;
@property (nonatomic, strong) NSURL *imageURL;
@end

@implementation TrafficCameraImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadImage
{
    if (self.imageView && self.imageURL) {
        self.activitySpinner.hidden = NO;
        [self.activitySpinner startAnimating];
        dispatch_queue_t downloadQ = dispatch_queue_create("ie.dcdevelopmentstudios.DubPark.imageview", 0);
        dispatch_async(downloadQ, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
                [self.activitySpinner stopAnimating];
                self.activitySpinner.hidden = YES;
            });
        });
    } else self.imageView.image = nil;
}

- (void)viewDidLoad
{
    NSLog(@"TrafficCameraImage: viewDidLoad");
    [super viewDidLoad];
	
    self.title = self.selectedTrafficCamera.name;
    self.imageURL = [[NSURL alloc] initWithString:self.selectedTrafficCamera.url];
    
    [self loadImage];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setActivitySpinner:nil];
    [super viewDidUnload];
}
@end