//
//  DisabledSpacesMapViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 12/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "DisabledSpacesMapViewController.h"
#import "MapOverlay.h"
#import "DisabledParkingSpaceInfo.h"

@implementation DisabledSpacesMapViewController

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
    
    
    // default to dublin city centre
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [self.selectedDisabledSpace.latitude doubleValue];
    zoomLocation.longitude= [self.selectedDisabledSpace.longitude doubleValue];
     
    MKCoordinateRegion region;
    region.center=zoomLocation;   // location
    MKCoordinateSpan span;
    span.latitudeDelta=0.008;               //  0.001 to 120
    span.longitudeDelta=0.008;
    region.span=span;
    [self.mapView setRegion:region animated:YES];
    self.title = self.selectedDisabledSpace.street;
    
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self plotDisabledSpacePosition];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)plotDisabledSpacePosition{
    
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.selectedDisabledSpace.latitude doubleValue];
    coordinate.longitude= [self.selectedDisabledSpace.longitude doubleValue];
    NSString *numbersOfSpaces = [NSString stringWithFormat:@"Diabled Spaces: %@",self.selectedDisabledSpace.spaces];
    
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:self.selectedDisabledSpace.street subTitle:numbersOfSpaces titleAddendum:nil coordinate:coordinate];
    [_mapView addAnnotation:annotation];
}


- (IBAction)showCarparkDetails:(id)sender {
    [self performSegueWithIdentifier:@"showCarparkDetails" sender:self];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
//    static NSString *identifier = @"DisabledSpaceMapOverlay";
//    if ([annotation isKindOfClass:[DisabledSpaceMapOverlay class]]) {
//        
//        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//        if (annotationView == nil) {
//            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//        } else {
//            annotationView.annotation = annotation;
//        }
//        
//        annotationView.enabled = YES;
//        annotationView.canShowCallout = YES;
//        return annotationView;
//    }
    
    return nil;
}

@end
