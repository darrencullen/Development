//
//  CombinedMapViewController.h
//  DublinCityParking
//
//  Created by darren cullen on 15/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CombinedMapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
- (IBAction)selectOverlayType:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;


@end
