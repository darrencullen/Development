//
//  DubParkInfoViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 19/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "DubParkInfoViewController.h"
#import "WebViewController.h"
#import <BugSense-iOS/BugSenseController.h>

@interface DubParkInfoViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableViewDubParkInfo;

@end

@implementation DubParkInfoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    @try{
        [super viewDidLoad];
        
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            self.tableViewDubParkInfo.backgroundView = nil;
            
            UIView *backView = [[UIView alloc] init];
            UIColor *backgroundColour = [UIColor colorWithRed:19.0/255.0 green:22.0/255.0 blue:78.0/255.0 alpha:1];
            [backView setBackgroundColor:backgroundColour];
            
            [self.tableViewDubParkInfo setBackgroundView:backView];
        }

        
    } @catch (NSException *exc) {
        BUGSENSE_LOG(exc, nil);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    @try{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,10, headerView.frame.size.width, 30)];
        
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            headerLabel.backgroundColor = [UIColor clearColor];
            headerLabel.textColor = [UIColor whiteColor];
            headerLabel.shadowColor = [UIColor grayColor];
            headerLabel.shadowOffset = CGSizeMake(0.0, 1.0);
            headerLabel.font = [UIFont boldSystemFontOfSize:18];
        }
        
        if(section == 0)
            headerLabel.text = @"App Details";
        else if(section == 1)
            headerLabel.text = @"Credits";
        else if(section == 2)
            headerLabel.text = @"Information Sources";

        
        [headerView addSubview:headerLabel];
        return headerView;
        
    } @catch (NSException *exc) {
        BUGSENSE_LOG(exc, nil);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && [self.view window] == nil) {
        self.view = nil;
    }
}

@end
