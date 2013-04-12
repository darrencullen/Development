//
//  DisabledSpacesMapViewController.h
//  DublinCityParking
//
//  Created by darren cullen on 12/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DisabledParkingSpaceInfo.h"


@interface DisabledSpacesMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) DisabledParkingSpaceInfo *selectedDisabledSpace;

@end