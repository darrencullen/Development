//
//  MoreViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 16/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "MoreViewController.h"
#import "WebViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

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
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag == 504){
        NSString *emailTitle = @"DubPark Feedback";
        NSArray *toRecipents = [NSArray arrayWithObject:@"dcdevelopmentstudios@gmail.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
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
        headerLabel.text = @"Live Data";
    else if(section == 1)
        headerLabel.text = @"Payment Details";
    else if(section == 2)
        headerLabel.text = @"Payment Exemptions";
    else if(section == 3)
        headerLabel.text = @"Parking Zones";
    else if(section == 4)
        headerLabel.text = @"Zone 1 - €2.90/hour";
    else if(section == 5)
        headerLabel.text = @"Zone 2 - €2.40/hour";
    else if(section == 6)
        headerLabel.text = @"Zone 3 - €1.40/hour";
    else if(section == 7)
        headerLabel.text = @"Zone 4 - €1.60/hour";
    else if(section == 8)
        headerLabel.text = @"Zone 5 - €1.00/hour";
    else if(section == 9)
        headerLabel.text = @"Zone 6 - €0.60/hour";
    else if(section == 10)
        headerLabel.text = @"Further Info";
    
    [headerView addSubview:headerLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}   

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showLiveDriveWebView"]){
        
        WebViewController *destViewController = segue.destinationViewController;
        destViewController.url = @"https://twitter.com/LiveDrive";
        destViewController.webViewTitle = @"Live Drive";
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"More Info" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
        
    } else if([segue.identifier isEqualToString:@"showParkingInformation"]){
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"More Info" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}

@end
