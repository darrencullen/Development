//
//  TrafficCamerasViewController.h
//  DublinCityParking
//
//  Created by darren cullen on 12/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrafficCamerasViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *trafficCameras;

@end