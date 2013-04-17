//
//  CarparkDetailsViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 14/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CarparkDetailsViewController.h"
#import "CarparkDetails.h"
#import "CarparkDetalsDescriptionViewController.h"

@interface CarparkDetailsViewController ()
@property (nonatomic, strong) NSMutableArray *carparkDetailSections;
@property (nonatomic, strong) NSMutableArray *carparkDetailLocation;
@property (nonatomic, strong) NSMutableArray *carparkDetailSpaces;
@property (nonatomic, strong) NSMutableArray *carparkDetailRates;
@property (nonatomic, strong) NSMutableArray *carparkDetailOther;
@property (nonatomic, strong) NSMutableArray *carparkDetailContact;
@property (nonatomic) int selectedRowTag;
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

- (NSMutableArray *)carparkDetailContact
{
    if (!_carparkDetailContact) {
        _carparkDetailContact = [[NSMutableArray alloc] init];
    } return _carparkDetailContact;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.carparkDetailSections = [[NSMutableArray alloc] initWithObjects:self.carparkDetailLocation, self.carparkDetailSpaces, self.carparkDetailRates, self.carparkDetailOther, self.carparkDetailContact, nil];
    
    self.title = self.selectedCarparkInfo.name;
    if (self.selectedCarparkInfo.favourite == YES){
         self.buttonFavs.image = [UIImage imageNamed:@"StarFull24.png"];
    } else {
         self.buttonFavs.image = [UIImage imageNamed:@"StarEmpty24.png"];
    }
    
    [self populateDetailArrays];
}

- (void) populateDetailArrays
{
    NSDictionary *detailItem;
    // Location 
    if (self.selectedCarparkInfo.details.region.length > 0){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.region, [NSNumber numberWithInt:1], nil];
        [self.carparkDetailLocation addObject:detailItem];
    }
    if (self.selectedCarparkInfo.address.length > 0){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.address, [NSNumber numberWithInt:2], nil];
        [self.carparkDetailLocation addObject:detailItem];
    }
    if (self.selectedCarparkInfo.details.directions.length > 0){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:@"How to get there", [NSNumber numberWithInt:20], nil];
        [self.carparkDetailLocation addObject:detailItem];
    }
    
    // Spaces
    if (self.selectedCarparkInfo.details.totalSpaces.length > 0){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.totalSpaces, @"Total", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:10], nil];
        [self.carparkDetailSpaces addObject:detailItem];
    }
    if (self.selectedCarparkInfo.details.disabledSpaces.length > 0){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.disabledSpaces, @"Disabled", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:11], nil];
        [self.carparkDetailSpaces addObject:detailItem];
    }
    if (self.selectedCarparkInfo.availableSpaces.length > 0){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.availableSpaces, @"Available", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:12], nil];
        [self.carparkDetailSpaces addObject:detailItem];
    }
    
    // Rates
    if (self.selectedCarparkInfo.details.hourlyRate.length > 0){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.hourlyRate, @"Hourly rate", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:13], nil];
        [self.carparkDetailRates addObject:detailItem];
    }
    if ((self.selectedCarparkInfo.details.otherRate1.length > 0) || (self.selectedCarparkInfo.details.otherRate2.length > 0)){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:@"Other rates", [NSNumber numberWithInt:21], nil];
        [self.carparkDetailRates addObject:detailItem];
    }
    
    // Other Details
    if (self.selectedCarparkInfo.details.heightRestrictions.length > 0){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.heightRestrictions, @"Max height", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:14], nil];
        [self.carparkDetailOther addObject:detailItem];
    }
    if (self.selectedCarparkInfo.details.openingHours.length > 0){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:@"Opening hours", [NSNumber numberWithInt:22], nil];
        [self.carparkDetailOther addObject:detailItem];
    }
    if (self.selectedCarparkInfo.details.services.length > 0){
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:@"Services available", [NSNumber numberWithInt:23], nil];
        [self.carparkDetailOther addObject:detailItem];
    }

    
    // Contact Details
    if (self.selectedCarparkInfo.details.phoneNumber.length > 0){
        NSDictionary *detailDescriptionValue;
        detailDescriptionValue = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCarparkInfo.details.phoneNumber, @"Phone", nil];
        detailItem = [NSDictionary dictionaryWithObjectsAndKeys:detailDescriptionValue, [NSNumber numberWithInt:15], nil];
        [self.carparkDetailContact addObject:detailItem];
    }
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
    NSArray *selectedSection = self.carparkDetailSections[indexPath.section];
    
    NSDictionary *detailItem = [selectedSection objectAtIndex:[indexPath row]];
    for (NSNumber *detailKey in detailItem) {
        if (([detailKey intValue] >0) && ([detailKey intValue] < 10)){
            static NSString *CellIdentifier = @"DescriptionCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.tag = [detailKey intValue];
            
            NSString *description = detailItem[detailKey];
            UILabel *detailDescription = (UILabel *)[cell viewWithTag:103];
            detailDescription.text = description;
            
            return cell;
            
        } else if (([detailKey intValue] >= 10) && ([detailKey intValue] < 20)){
            static NSString *CellIdentifier = @"DescriptionValueCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.tag = [detailKey intValue];
            
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
            cell.tag = [detailKey intValue];
            
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
    else if(section == 4){
        if ([_carparkDetailContact count] > 0){
            headerLabel.text = @"Contact Details";
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag >= 20){
        self.selectedRowTag = cell.tag;
        [self performSegueWithIdentifier:@"showFurtherDetails" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"showFurtherDetails"]){
        CarparkDetalsDescriptionViewController *destViewController = segue.destinationViewController;
        
        switch (self.selectedRowTag) {
            case 20:
                destViewController.details = self.selectedCarparkInfo.details.directions;
                destViewController.title = @"Directions";
                break;
                
            case 21:
                destViewController.details = self.selectedCarparkInfo.details.otherRate1;
                destViewController.title = @"Other Rates";
                break;
                
            case 22:
                destViewController.details = self.selectedCarparkInfo.details.openingHours;
                destViewController.title = @"Opening Hours";
                break;
                
            case 23:
                destViewController.details = self.selectedCarparkInfo.details.services;
                destViewController.title = @"Services Available";
                break;
                
            default:
                break;
        }
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Details" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}

- (IBAction)setFavouriteCarpark:(id)sender {
    // set up the managedObjectContext to read data from CoreData
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CarparkInfo"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"code=%@",self.selectedCarparkInfo.code]];

    NSError *error;
    CarparkInfo *cgCarpark;
    
    UIImage *newFavImage;
    
    cgCarpark = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    
    NSString *alertMessage;
    if (cgCarpark.favourite == NO){
        cgCarpark.favourite = 1;
        newFavImage = [UIImage imageNamed:@"StarFull24.png"];
        alertMessage = @"Added to favourites list";
    } else {
        cgCarpark.favourite = 0;
        newFavImage = [UIImage imageNamed:@"StarEmpty24.png"];
        alertMessage = @"Removed from favourites list";
    }

    error = nil;
    if (![self.managedObjectContext save:&error]) {
        //Handle any error with the saving of the context
        NSLog(@"Error saving");
    } else {
        self.buttonFavs.image = newFavImage;
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(self.selectedCarparkInfo.name, @"AlertView")
                                  message:NSLocalizedString(alertMessage, @"AlertView")
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"OK", @"AlertView")
                                  otherButtonTitles:nil, nil];
        [alertView show];
        
        [self performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:2];
    }
}

-(void)dismissAlertView:(UIAlertView*)favouritesUpdateAlert
{
	[favouritesUpdateAlert dismissWithClickedButtonIndex:-1 animated:YES];
}
@end
