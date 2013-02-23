//
//  CarparkDetails.h
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 21/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CarparkInfo;

@interface CarparkDetails : NSManagedObject

@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * totalSpaces;
@property (nonatomic, retain) NSString * disabledSpaces;
@property (nonatomic, retain) NSString * heightRestrictions;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * directions;
@property (nonatomic, retain) NSString * services;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * openingHours;
@property (nonatomic, retain) NSString * hourlyRate;
@property (nonatomic, retain) NSString * otherRate1;
@property (nonatomic, retain) NSString * otherRate2;
@property (nonatomic, retain) CarparkInfo *info;

@end
