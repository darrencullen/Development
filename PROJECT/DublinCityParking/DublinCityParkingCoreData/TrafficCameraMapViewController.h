//
//  TrafficCameraMapViewController.h
//  DublinCityParking
//
//  Created by darren cullen on 13/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TrafficCameraInfo.h"

@interface TrafficCameraMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) TrafficCameraInfo *selectedTrafficCamera;

@end
