//
//  MoreViewController.m
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 27/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
       
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // TODO: IMPLEMENT HEADER CODE
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,10, headerView.frame.size.width, 30)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.shadowColor = [UIColor grayColor];
    headerLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    
    if(section == 0)
        headerLabel.text = @"Additional Information";
    else if(section == 1)
        headerLabel.text = @"App Details";
    
    [headerView addSubview:headerLabel];
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

@end
