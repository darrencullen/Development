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

@implementation CarparkDetailsViewController{
    CarparkDetails *selectedCarparkDetails;
}

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
    
    self.title = self.selectedCarparkInfo.name;
    selectedCarparkDetails = self.selectedCarparkInfo.details;
    
    self.region.text = selectedCarparkDetails.region;
    self.address.text = self.selectedCarparkInfo.address;
    self.totalSpaces.text = selectedCarparkDetails.totalSpaces;
    self.availableSpaces.text = self.selectedCarparkInfo.availableSpaces;
    self.disabledSpaces.text = selectedCarparkDetails.disabledSpaces;
    self.openingHours.text = selectedCarparkDetails.openingHours;
    self.hourlyRate.text = selectedCarparkDetails.hourlyRate;
    self.otherRate.text = selectedCarparkDetails.otherRate1;
    self.maxHeight.text = selectedCarparkDetails.heightRestrictions;
    self.phone.text = selectedCarparkDetails.phoneNumber;
    self.services.text = selectedCarparkDetails.services;
    self.directions.text = selectedCarparkDetails.directions;
    
    [self.view setNeedsDisplay];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,10, headerView.frame.size.width, 30)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.shadowColor = [UIColor grayColor];
    headerLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    
    if(section == 0)
        headerLabel.text = @"Southwest";
    else if(section == 1)
        headerLabel.text = @"Southeast";
    else if(section == 2)
        headerLabel.text = @"Northeast";
    else
        headerLabel.text = @"Northwest";
    
    [headerView addSubview:headerLabel];
    return headerView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
