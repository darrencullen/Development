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
#import "WebViewController.h"
#import <BugSense-iOS/BugSenseController.h>

@implementation CarparkMapViewController{
    CarparkDetails *selectedCarparkDetails;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentLocation;
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
    
    // start recording current location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
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
        if (self.selectedCarparkInfo.favourite == 1)
            [leftButton setImage:[UIImage imageNamed:@"StarFull24-3.png"] forState:UIControlStateNormal];
        else
            [leftButton setImage:[UIImage imageNamed:@"StarEmpty24-3.png"] forState:UIControlStateNormal];
        
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
        [self setFavouriteCarpark];
        
    } else if(control.tag == 2) {
        [self performSegueWithIdentifier:@"showCarparkDirections" sender:self];
    }
    
    [self plotCarparkPosition];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSException* locationManagerException = [NSException
                                      exceptionWithName:@"CarparkMapViewController.locationManager.didFailWithError"
                                      reason:@"Failed to Get Your Location"
                                      userInfo:nil];
    
    BUGSENSE_LOG(locationManagerException, nil);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{    
    if (newLocation != nil) {
        currentLocation.latitude = newLocation.coordinate.latitude;
        currentLocation.longitude = newLocation.coordinate.longitude;
        
        NSLog(@"Current location: latitude=%.8f; longitude=%.8f",currentLocation.latitude,currentLocation.longitude);
        [locationManager stopUpdatingLocation];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [locationManager startUpdatingLocation];
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
    
    MapOverlay *annotation = [[MapOverlay alloc] initWithName:self.selectedCarparkInfo.name subTitle:self.selectedCarparkInfo.address titleAddendum:self.selectedCarparkInfo.availableSpaces coordinate:coordinate];
    
    [self.mapView addAnnotation:annotation];
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];
}

- (void)setFavouriteCarpark {
    // set up the managedObjectContext to read data from CoreData
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CarparkInfo"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"code=%@",self.selectedCarparkInfo.code]];
    
    NSError *error;
    CarparkInfo *cgCarpark;
    
    cgCarpark = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    
    NSString *alertMessage;
    if (cgCarpark.favourite == NO){
        cgCarpark.favourite = 1;
        alertMessage = @"Added to favourites list";
    } else {
        cgCarpark.favourite = 0;
        alertMessage = @"Removed from favourites list";
    }
    
    error = nil;
    if (![self.managedObjectContext save:&error]) {
        //Handle any error with the saving of the context
        NSLog(@"Error saving");
    } else {       
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(self.selectedCarparkInfo.name, @"AlertView")
                                  message:NSLocalizedString(alertMessage, @"AlertView")
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"OK", @"AlertView")
                                  otherButtonTitles:nil, nil];
        [alertView show];
        
        [self performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:2];
    }
}

-(void)dismissAlertView:(UIAlertView*)favouritesUpdateAlert
{
	[favouritesUpdateAlert dismissWithClickedButtonIndex:-1 animated:YES];
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
        
    } else if([segue.identifier isEqualToString:@"showCarparkDirections"]){
        
        NSString *directionsURL = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%1.6f,%1.6f&daddr=%1.6f,%1.6f",currentLocation.latitude, currentLocation.longitude, self.selectedCarparkInfo.details.latitude, self.selectedCarparkInfo.details.longitude];
        
        WebViewController *destViewController = segue.destinationViewController;
        destViewController.url = directionsURL;
        destViewController.title = self.title;
        destViewController.hideNavigationToolbar = YES;
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}


@end
