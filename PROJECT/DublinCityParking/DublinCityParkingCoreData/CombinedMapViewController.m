//
//  CombinedMapViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 15/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CombinedMapViewController.h"
#import "MapOverlay.h"
#import "CarparkInfo.h"
#import "CarparkDetails.h"
#import "DisabledParkingSpaceInfo.h"
#import "TrafficCameraInfo.h"

@interface CombinedMapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSArray *carparkLocations;
@property (nonatomic, strong) NSArray *disabledParkingLocations;
@property (nonatomic, strong) NSArray *trafficCameraLocations;
@end

@implementation CombinedMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initialiseMap];
    
//    [self getCarparkDetails];
//    [self createCarparkOverlays];
    
    [self getDisabledParkingDetails];
    [self getTrafficCameraDetails];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.segmentedControlOverlayTypes.selectedSegmentIndex == 0){
        [self getCarparkDetails];
        [self createCarparkOverlays];
    }
}

- (void)initialiseMap
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 53.34719;
    zoomLocation.longitude = -6.2591;
    
    MKCoordinateRegion region;
    region.center=zoomLocation;
    MKCoordinateSpan span;
    span.latitudeDelta=0.017;
    span.longitudeDelta=0.017;
    region.span=span;
    [self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearOverlays
{ 
    [self.mapView removeAnnotations:[self.mapView annotations]];
}

- (void)getCarparkDetails
{
    // set up the managedObjectContext to read data from CoreData
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CarparkInfo"
                                              inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    NSError *error;
    self.carparkLocations = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)getDisabledParkingDetails
{
    // set up the managedObjectContext to read data from CoreData
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DisabledParkingSpaceInfo"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError *error;
    self.disabledParkingLocations = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)getTrafficCameraDetails
{
    // set up the managedObjectContext to read data from CoreData
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TrafficCameraInfo"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError *error;
    self.trafficCameraLocations = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)createCarparkOverlays
{
    [self clearOverlays];
    for (CarparkInfo *carpark in self.carparkLocations){
        [self createCarparkOverlay:carpark];
    }
    self.navigationBar.title = @"Carpark Locations";
}

- (void)createCarparkOverlay:(CarparkInfo *)carpark
{    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = carpark.details.latitude;
    coordinate.longitude= carpark.details.longitude;
    
    NSString *numbersOfSpaces = [NSString stringWithFormat:@"Spaces: %@",carpark.availableSpaces];
    
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:carpark.name subTitle:carpark.address titleAddendum:numbersOfSpaces coordinate:coordinate];
    [_mapView addAnnotation:annotation];

}

- (void)createDisabledSpaceOverlays
{
    [self clearOverlays];
    for (DisabledParkingSpaceInfo *disabledSpace in self.disabledParkingLocations){
        [self createDisabledSpaceOverlay:disabledSpace];
    }
    self.navigationBar.title = @"Disabled Parking Locations";
}

- (void)createDisabledSpaceOverlay:(DisabledParkingSpaceInfo *)disabledSpace
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [disabledSpace.latitude doubleValue];
    coordinate.longitude = [disabledSpace.longitude doubleValue];
    
    NSString *numbersOfSpaces = [NSString stringWithFormat:@"Disabled Spaces: %@",disabledSpace.spaces];
    
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:disabledSpace.street subTitle:numbersOfSpaces titleAddendum:nil coordinate:coordinate];
    [_mapView addAnnotation:annotation];
    
}

- (void)createTrafficCameraOverlays
{
    [self clearOverlays];
    for (TrafficCameraInfo *trafficCamera in self.trafficCameraLocations){
        [self createTraficCameraOverlay:trafficCamera];
    }
    self.navigationBar.title = @"Traffic Camera Locations";
}

- (void)createTraficCameraOverlay:(TrafficCameraInfo *)camera
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [camera.latitude doubleValue];
    coordinate.longitude = [camera.longitude doubleValue];
    
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:camera.name subTitle:nil titleAddendum:nil coordinate:coordinate];
    [_mapView addAnnotation:annotation];
    
}

- (IBAction)selectOverlayType:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0){
        [self getCarparkDetails];
        [self createCarparkOverlays];
    } else if (sender.selectedSegmentIndex == 1){
        [self createDisabledSpaceOverlays];
    } else if (sender.selectedSegmentIndex == 2){
        [self createTrafficCameraOverlays];
    }
}
@end

