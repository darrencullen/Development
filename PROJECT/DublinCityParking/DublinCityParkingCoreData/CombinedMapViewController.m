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
    
    [self getCarparkDetails];
    [self createCarparkOverlays];
    
    [self getDisabledParkingDetails];
    [self getTrafficCameraDetails];

}



- (void)initialiseMap
{
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearOverlays
{
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
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

- (IBAction)selectOverlayType:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0){
        [self createCarparkOverlays];
    }
}
@end

