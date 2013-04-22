//
//  CarparkMapViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 26/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CarparkMapViewController.h"
#import "CarparkDetailsViewController.h"
#import "MapOverlay.h"

@implementation CarparkMapViewController{
    CarparkDetails *selectedCarparkDetails;
}
//@synthesize locationManager;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.selectedCarparkInfo.name;
    selectedCarparkDetails = self.selectedCarparkInfo.details;
    _mapView.delegate = self;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = selectedCarparkDetails.latitude;
    zoomLocation.longitude= selectedCarparkDetails.longitude;
    
    MKCoordinateSpan span;
    span.latitudeDelta=0.008;             
    span.longitudeDelta=0.008;
    
    MKCoordinateRegion region;
    region.center=zoomLocation;   
    region.span=span;
    [self.mapView setRegion:region animated:YES];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"CarparkMapOverlay";
    if ([annotation isKindOfClass:[MapOverlay class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:[UIImage imageNamed:@"StarFull24-3.png"] forState:UIControlStateNormal];
        [leftButton setTitle:annotation.title forState:UIControlStateNormal];
        leftButton.frame = CGRectMake(0, 0, 32, 32);
        leftButton.tag = 1;
        annotationView.leftCalloutAccessoryView = leftButton;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:[UIImage imageNamed:@"directions38.png"] forState:UIControlStateNormal];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(0, 0, 32, 32);
        rightButton.tag = 2;
        annotationView.rightCalloutAccessoryView = rightButton;
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    if (control.tag == 1){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(self.selectedCarparkInfo.name, @"AlertView")
                                  message:NSLocalizedString(@"Added to favourites list", @"AlertView")
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"OK", @"AlertView")
                                  otherButtonTitles:nil, nil];
        [alertView show];
        
    } else if(control.tag == 2) {
        
        NSString *stringURL = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%1.6f,%1.6f&daddr=53.303349,-6.238724",
                               self.selectedCarparkInfo.details.latitude, self.selectedCarparkInfo.details.longitude];
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self plotCarparkPosition];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)plotCarparkPosition{
    
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = selectedCarparkDetails.latitude;
    coordinate.longitude = selectedCarparkDetails.longitude;
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.008;
    span.longitudeDelta = 0.008;
    region.span = span;
    region.center = coordinate;
    
//    NSString *numbersOfSpaces = [NSString stringWithFormat:@"Spaces: %@",self.selectedCarparkInfo.availableSpaces];
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:self.selectedCarparkInfo.name subTitle:self.selectedCarparkInfo.address titleAddendum:self.selectedCarparkInfo.availableSpaces coordinate:coordinate];
    
    [self.mapView addAnnotation:annotation];
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];
}


- (IBAction)showCarparkDetails:(id)sender {
    [self performSegueWithIdentifier:@"showCarparkDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"showCarparkDetails"]){
        
        CarparkDetailsViewController *destViewController = segue.destinationViewController;
        destViewController.selectedCarparkInfo = self.selectedCarparkInfo;
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}
@end
