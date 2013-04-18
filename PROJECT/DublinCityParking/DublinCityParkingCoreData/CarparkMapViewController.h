//
//  CarparkMapViewController.h
//  DublinCityParking
//
//  Created by darren cullen on 26/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CarparkInfo.h"
#import "CarparkDetails.h"

@interface CarparkMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) CarparkInfo *selectedCarparkInfo;

- (IBAction)showCarparkDetails:(id)sender;

@end
