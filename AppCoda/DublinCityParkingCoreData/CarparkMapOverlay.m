//
//  CarparkMapOverlay.m
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 27/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CarparkMapOverlay.h"

@implementation CarparkMapOverlay
@synthesize name = _name;
@synthesize address = _address;
@synthesize availableSpaces = _availableSpaces;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString*)carparkName spaces:(NSString *)carparkAvailableSpaces address:(NSString*)carparkAddress coordinate:(CLLocationCoordinate2D)carparkCoordinate {
    if ((self = [super init])) {
        _name = [carparkName copy];
        _address = [carparkAddress copy];
        _availableSpaces = [carparkAvailableSpaces copy];
        _coordinate = carparkCoordinate;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _name;
}

- (NSString *)subtitle {
    return _address;
}

@end
