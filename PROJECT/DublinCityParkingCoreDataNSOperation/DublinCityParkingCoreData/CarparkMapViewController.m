//
//  CarparkMapViewController.m
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 26/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CarparkMapViewController.h"
#import "CarparkDetailsViewController.h"
#import "CarparkMapOverlay.h"
#import "CarparkInfo.h"
#import "CarparkDetails.h"

@interface CarparkMapViewController ()

@end

@implementation CarparkMapViewController{
    CarparkDetails *selectedCarparkDetails;
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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    
//    // set up the managedObjectContext to read data from CoreData
//    id delegate = [[UIApplication sharedApplication] delegate];
//    self.managedObjectContext = [delegate managedObjectContext];
//    
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"CarparkInfo" inManagedObjectContext:self.managedObjectContext];
//    
//    [fetchRequest setEntity:entity];
//    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"code=%@",self.selectedCarparkCode]];
//    
//    
//    NSError *error;
//   // CarparkInfo *cgCarpark;
//    
//    selectedCarparkInfo = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    
    
    
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", self.selectedCarparkCode];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"CarparkInfo" inManagedObjectContext:self.managedObjectContext];
//    
//    [fetchRequest setEntity:entity];
//    [fetchRequest setPredicate:predicate];
//    
//    NSError *error;
//    NSArray *carparks = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    //selectedCarparkInfo = carparks[0];
    //selectedCarparkDetails = selectedCarparkInfo.details;
    
    selectedCarparkDetails = self.selectedCarparkInfo.details;
    
    // default to dublin city centre
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = selectedCarparkDetails.latitude;
    zoomLocation.longitude= selectedCarparkDetails.longitude;
    
    MKCoordinateRegion region;
    region.center=zoomLocation;   // location
    MKCoordinateSpan span;
    span.latitudeDelta=0.008;               //  0.001 to 120
    span.longitudeDelta=0.008;
    region.span=span;
    [self.mapView setRegion:region animated:YES];
    self.title = self.selectedCarparkInfo.name;
    
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self plotCarparkPosition];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)plotCarparkPosition{
    
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
        
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = selectedCarparkDetails.latitude;
    coordinate.longitude = selectedCarparkDetails.longitude;
    CarparkMapOverlay *annotation = [[CarparkMapOverlay alloc] initWithName:self.selectedCarparkInfo.name spaces:self.selectedCarparkInfo.availableSpaces address:self.selectedCarparkInfo.address coordinate:coordinate];
    [_mapView addAnnotation:annotation];
}


- (IBAction)showCarparkDetails:(id)sender {
    [self performSegueWithIdentifier:@"showCarparkDetails" sender:self];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"CarparkMapOverlay";
    if ([annotation isKindOfClass:[CarparkMapOverlay class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image=[UIImage imageNamed:@"mappointer.png"];
        return annotationView;
    }
    
    return nil;    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"showCarparkDetails"]){
        
        CarparkDetailsViewController *destViewController = segue.destinationViewController;
        destViewController.selectedCarparkInfo = self.selectedCarparkInfo;
//        destViewController.selectedCarparkDetails = self.selectedCarparkInfo.details;
//        destViewController.managedObjectContext = self.managedObjectContext;
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}
@end
