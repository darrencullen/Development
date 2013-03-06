//
//  CarparkDetailsViewController.h
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 27/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarparkInfo.h"
#import "carparkDetails.h"

@interface CarparkDetailsViewController : UIViewController

@property (nonatomic, strong) CarparkInfo *selectedCarparkInfo;
//@property (nonatomic, strong) CarparkDetails *selectedCarparkDetails;

@end
