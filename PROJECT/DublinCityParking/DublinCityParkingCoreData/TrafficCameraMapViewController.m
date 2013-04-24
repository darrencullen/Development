//
//  TrafficCameraMapViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 13/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "TrafficCameraMapViewController.h"
#import "MapOverlay.h"
#import <BugSense-iOS/BugSenseController.h>

@interface TrafficCameraMapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation TrafficCameraMapViewController{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentLocation;
}

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
    @try{
        [super viewDidLoad];
        
        // start recording current location
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.title = self.selectedTrafficCamera.name;
        _mapView.delegate = self;

        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = [self.selectedTrafficCamera.latitude doubleValue];
        zoomLocation.longitude= [self.selectedTrafficCamera.longitude doubleValue];
        
        MKCoordinateRegion region;
        region.center=zoomLocation;
        MKCoordinateSpan span;
        span.latitudeDelta=0.008;
        span.longitudeDelta=0.008;
        region.span=span;
        [self.mapView setRegion:region animated:YES];
        
    } @catch (NSException *exc) {
        BUGSENSE_LOG(exc, nil);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self plotTrafficCameraPosition];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)plotTrafficCameraPosition{    
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.selectedTrafficCamera.latitude doubleValue];
    coordinate.longitude= [self.selectedTrafficCamera.longitude doubleValue];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.008;
    span.longitudeDelta = 0.008;
    region.span = span;
    region.center = coordinate;
    
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:self.selectedTrafficCamera.name subTitle:nil titleAddendum:nil coordinate:coordinate];
    [_mapView addAnnotation:annotation];
    
    [self.mapView addAnnotation:annotation];
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];
}

@end
