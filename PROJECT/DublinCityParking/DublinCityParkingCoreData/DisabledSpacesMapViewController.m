//
//  DisabledSpacesMapViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 12/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "DisabledSpacesMapViewController.h"
#import "MapOverlay.h"

@interface DisabledSpacesMapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end


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

    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [self.selectedDisabledSpace.latitude doubleValue];
    zoomLocation.longitude= [self.selectedDisabledSpace.longitude doubleValue];
     
    MKCoordinateRegion region;
    region.center=zoomLocation;   
    MKCoordinateSpan span;
    span.latitudeDelta=0.008;              
    span.longitudeDelta=0.008;
    region.span=span;
    [self.mapView setRegion:region animated:YES];
    self.title = self.selectedDisabledSpace.street;    
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self plotDisabledSpacePosition];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)plotDisabledSpacePosition{ 
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.selectedDisabledSpace.latitude doubleValue];
    coordinate.longitude= [self.selectedDisabledSpace.longitude doubleValue];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.008;
    span.longitudeDelta = 0.008;
    region.span = span;
    region.center = coordinate;
    
    NSString *numbersOfSpaces = [NSString stringWithFormat:@"Disabled Spaces: %@",self.selectedDisabledSpace.spaces];
    
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:self.selectedDisabledSpace.street subTitle:numbersOfSpaces titleAddendum:nil coordinate:coordinate];
    [_mapView addAnnotation:annotation];
    
    [self.mapView addAnnotation:annotation];
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];
}


@end
