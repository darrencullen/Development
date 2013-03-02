//
//  CarparkDetailsViewController.m
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 27/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CarparkDetailsViewController.h"

@interface CarparkDetailsViewController ()

@end

@implementation CarparkDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = self.selectedCarparkCode;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
