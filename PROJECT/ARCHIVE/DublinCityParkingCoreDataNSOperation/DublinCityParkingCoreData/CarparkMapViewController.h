//
//  CarparkMapViewController.h
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 26/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CarparkInfo.h"
#import "carparkDetails.h"

@interface CarparkMapViewController : UIViewController <MKMapViewDelegate>

//@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CarparkInfo *selectedCarparkInfo;
//@property (nonatomic, strong) CarparkDetails *selectedCarparkDetails;

- (IBAction)showCarparkDetails:(id)sender;

@end
