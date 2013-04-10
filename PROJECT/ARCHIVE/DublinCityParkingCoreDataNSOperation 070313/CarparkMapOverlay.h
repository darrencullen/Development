//
//  CarparkMapOverlay.h
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 27/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CarparkMapOverlay : NSObject <MKAnnotation> {
    NSString *name;
    NSString *address;
    NSString *availableSpaces;
    CLLocationCoordinate2D coordinate;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (copy) NSString *availableSpaces;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)carparkName spaces:(NSString *)carparkAvailableSpaces address:(NSString*)carparkAddress coordinate:(CLLocationCoordinate2D)carparkCoordinate;

@end

