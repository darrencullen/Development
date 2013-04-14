//
//  CarparkDetailsViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 14/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CarparkDetailsViewController.h"
#import "CarparkDetails.h"

@interface CarparkDetailsViewController ()
@property (nonatomic, strong) NSMutableArray *carparkDetailSections;
@property (nonatomic, strong) NSMutableArray *carparkDetailLocation;
@property (nonatomic, strong) NSMutableArray *carparkDetailSpaces;
@property (nonatomic, strong) NSMutableArray *carparkDetailRates;
@property (nonatomic, strong) NSMutableArray *carparkDetailOther;

@end

@implementation CarparkDetailsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)carparkDetailLocation
{
    if (!_carparkDetailLocation) {
        _carparkDetailLocation = [[NSMutableArray alloc] init];
    } return _carparkDetailLocation;
}

- (NSMutableArray *)carparkDetailSpaces
{
    if (!_carparkDetailSpaces) {
        _carparkDetailSpaces = [[NSMutableArray alloc] init];
    } return _carparkDetailSpaces;
}

- (NSMutableArray *)carparkDetailRates
{
    if (!_carparkDetailRates) {
        _carparkDetailRates = [[NSMutableArray alloc] init];
    } return _carparkDetailRates;
}

- (NSMutableArray *)carparkDetailOther
{
    if (!_carparkDetailOther) {
        _carparkDetailOther = [[NSMutableArray alloc] init];
    } return _carparkDetailOther;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.carparkDetailSections = [[NSMutableArray alloc] initWithObjects:self.carparkDetailLocation, self.carparkDetailSpaces, self.carparkDetailRates, self.carparkDetailOther, nil];
    
    [self populateDetailArrays];
}

- (void) populateDetailArrays
{
    NSDictionary *detailItem;
    // Location 
    if (self.selectedCarparkInfo.details.region){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.region, [NSNumber numberWithInt:1], nil];
        [self.carparkDetailLocation addObject:detailItem];
    }
    if (self.selectedCarparkInfo.address){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.address, [NSNumber numberWithInt:2], nil];
        [self.carparkDetailLocation addObject:detailItem];
    }
    if (self.selectedCarparkInfo.details.directions){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:@"How to get there", [NSNumber numberWithInt:20], nil];
        [self.carparkDetailLocation addObject:detailItem];
    }
    
    // Spaces
    if (self.selectedCarparkInfo.details.totalSpaces){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.totalSpaces, @"Total", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:10], nil];
        [self.carparkDetailSpaces addObject:detailItem];
    }
    if (self.selectedCarparkInfo.details.disabledSpaces){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.disabledSpaces, @"Disabled", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:11], nil];
        [self.carparkDetailSpaces addObject:detailItem];
    }
    if (self.selectedCarparkInfo.availableSpaces){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.availableSpaces, @"Available", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:12], nil];
        [self.carparkDetailSpaces addObject:detailItem];
    }
    
    // Rates
    if (self.selectedCarparkInfo.details.hourlyRate){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.hourlyRate, @"Hourly rate", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:13], nil];
        [self.carparkDetailRates addObject:detailItem];
    }
    if ((self.selectedCarparkInfo.details.otherRate1) || (self.selectedCarparkInfo.details.otherRate2)){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:@"Other rates", [NSNumber numberWithInt:21], nil];
        [self.carparkDetailRates addObject:detailItem];
    }
    
    // Other Details
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.carparkDetailSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionContents = [self.carparkDetailSections objectAtIndex:section];
    NSInteger rows = [sectionContents count];
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyle1 reuseIdentifier:CellIdentifier];
//    }
    
    NSArray *selectedSection = self.carparkDetailSections[indexPath.section];
    
    NSDictionary *detailItem = [selectedSection objectAtIndex:[indexPath row]];
    for (NSNumber *detailKey in detailItem) {
        if (([detailKey intValue] >0) && ([detailKey intValue] < 10)){
            static NSString *CellIdentifier = @"DescriptionCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                       
            NSString *description = detailItem[detailKey];
            UILabel *detailDescription = (UILabel *)[cell viewWithTag:103];
            detailDescription.text = description;
            
            return cell;
            
        } else if (([detailKey intValue] >= 10) && ([detailKey intValue] < 20)){
            static NSString *CellIdentifier = @"DescriptionValueCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            NSDictionary *descriptionItem = detailItem[detailKey];
            for (NSString *descriptionKey in descriptionItem){
                NSString *header = descriptionKey;
                UILabel *detailHeader = (UILabel *)[cell viewWithTag:101];
                detailHeader.text = header;
           
            
                NSString *description = descriptionItem[descriptionKey];
                UILabel *detailDescription = (UILabel *)[cell viewWithTag:102];
                detailDescription.text = description;
            }
            
            return cell;
            
        } else if ([detailKey intValue] >= 20){
            static NSString *CellIdentifier = @"DrilldownCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            NSString *description = detailItem[detailKey];
            UILabel *detailDescription = (UILabel *)[cell viewWithTag:100];
            detailDescription.text = description;
            
            return cell;

        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,10, headerView.frame.size.width, 30)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.shadowColor = [UIColor grayColor];
    headerLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    
    if(section == 0){
        if ([_carparkDetailLocation count] > 0){
            headerLabel.text = @"Location";
            [headerView addSubview:headerLabel];
        }
    }
    else if(section == 1){
        if ([_carparkDetailSpaces count] > 0){
            headerLabel.text = @"Spaces";
            [headerView addSubview:headerLabel];
        }
    }
    else if(section == 2){
        if ([_carparkDetailRates count] > 0){
            headerLabel.text = @"Rates";
            [headerView addSubview:headerLabel];
        }
    }
    else if(section == 3){
        if ([_carparkDetailOther count] > 0){
            headerLabel.text = @"Other Details";
            [headerView addSubview:headerLabel];
        }
    }
    
    return headerView;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
