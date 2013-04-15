//
//  CombinedMapViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 15/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CombinedMapViewController.h"
#import "MapOverlay.h"

@interface CombinedMapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation CombinedMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 53.345704;
    zoomLocation.longitude = -6.266396;
    
    MKCoordinateRegion region;
    region.center=zoomLocation;
    MKCoordinateSpan span;
    span.latitudeDelta=0.017;
    span.longitudeDelta=0.017;
    region.span=span;
    [self.mapView setRegion:region animated:YES];
    [self populateLocations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateLocations
{
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 53.345704;;
    coordinate.longitude= -6.266396;
    
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:@"TEST 1" subTitle:nil titleAddendum:nil coordinate:coordinate];
    [_mapView addAnnotation:annotation];
    
    
    coordinate.latitude = 53.3400;
    coordinate.longitude= -6.2685;
    
    annotation = [[MapOverlay alloc] initWithName:@"TEST 2" subTitle:nil titleAddendum:nil coordinate:coordinate];
    //annotation
    [_mapView addAnnotation:annotation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
@end

