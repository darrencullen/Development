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
        return annotationView;
    }
    
    return nil;
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
    
    NSString *numbersOfSpaces = [NSString stringWithFormat:@"Spaces: %@",self.selectedCarparkInfo.availableSpaces];
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:self.selectedCarparkInfo.name subTitle:self.selectedCarparkInfo.address titleAddendum:numbersOfSpaces coordinate:coordinate];
    
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
