//
//  DCDMasterViewController.m
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 21/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CarparkListViewController.h"
#import "CarparkInfo.h"
#import "XMLParser.h"
#import "CarparkMapViewController.h"

@interface CarparkListViewController ()

@end

@implementation CarparkListViewController
{
    XMLParser *xmlParser;
    CarparkInfo *selectedCarpark;
    NSMutableArray *southeastCarparks;
    NSMutableArray *southwestCarparks;
    NSMutableArray *northeastCarparks;
    NSMutableArray *northwestCarparks;
    NSMutableArray *carparkLocations;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    
    southeastCarparks = [[NSMutableArray alloc] init];
    southwestCarparks = [[NSMutableArray alloc] init];
    northeastCarparks = [[NSMutableArray alloc] init];
    northwestCarparks = [[NSMutableArray alloc] init];
    carparkLocations = [[NSMutableArray alloc] initWithObjects:southeastCarparks, southwestCarparks, northeastCarparks, northwestCarparks, nil];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"CarparkInfo" inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError *error;
    self.carparkInfos = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (CarparkInfo *carpark in self.carparkInfos){
        if ([carpark.details.region isEqualToString:@"Southeast"]){
            [southeastCarparks addObject:carpark];
        } else if ([carpark.details.region isEqualToString:@"Southwest"]){
            [southwestCarparks addObject:carpark];
        } else if ([carpark.details.region isEqualToString:@"Northeast"]){
            [northeastCarparks addObject:carpark];
        } else if ([carpark.details.region isEqualToString:@"Northwest"]){
            [northwestCarparks addObject:carpark];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadXMLData)
                                                 name:@"appDidBecomeActive"
                                               object:nil];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self loadXMLData];
    NSLog(@"viewDidAppear");
}


- (void) loadXMLData {
	NSLog(@"loadXMLData");
    
	NSOperationQueue *queue = [NSOperationQueue new];
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(loadXMLDataWithOperation)
																			  object:nil];
	[queue addOperation:operation];
}

- (void) loadXMLDataWithOperation {
    xmlParser = [[XMLParser alloc] loadXMLByURL:@"http://www.dublincity.ie/dublintraffic/cpdata.xml"];
	
	[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return carparkLocations.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [self.carparkInfos count];
    
    NSArray *sectionContents = [carparkLocations objectAtIndex:section];
    NSInteger rows = [sectionContents count];
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    // maybe use region as a cell identifier
    static NSString *CellIdentifier = @"CarparkCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *selectedSection = carparkLocations[indexPath.section];
    selectedCarpark = [selectedSection objectAtIndex:[indexPath row]];
    //selectedCarpark = [self.carparkInfos objectAtIndex:indexPath.row];
    
    NSLog(@"%ld;%ld;%@", (long)indexPath.section, (long)indexPath.row, selectedCarpark.name);
    
    UILabel *carparkNameLabel = (UILabel *)[cell viewWithTag:100];
    carparkNameLabel.text = selectedCarpark.name;
    
    UILabel *carparkAddressLabel = (UILabel *)[cell viewWithTag:101];
    carparkAddressLabel.text = [NSString stringWithFormat:@"%@", selectedCarpark.address];
    
    UILabel *availableSpacesLabel = (UILabel *)[cell viewWithTag:102];
    availableSpacesLabel.text = selectedCarpark.availableSpaces;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width, 30)];
    
//    headerLabel.textAlignment = UITextAlignmentRight;
//    headerLabel.text = [titleArray objectAtIndex:section];
//    headerLabel.backgroundColor = [UIColor clearColor];
//    
//    [headerView addSubview:headerLabel];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(200,5.0f, label.frame.size.width, label.frame.size.height);
    
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
    return headerLabel;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
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


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSArray *selectedSection = carparkLocations[indexPath.section];
    selectedCarpark = [selectedSection objectAtIndex:[indexPath row]];
    
    //selectedCarpark = [self.carparkInfos objectAtIndex:indexPath.row];
    // do a segue based on the indexPath or do any setup later in prepareForSegue
    [self performSegueWithIdentifier:@"showCarparkMap" sender:self];
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"showCarparkMap"]){
        
        // NSIndexPath *indexPath =  selectedRow;
        // do some prep based on indexPath, if needed
        
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedRow];
//        UITextField *getTextView = (UITextField*)[cell.contentView viewWithTag:100];
        
        CarparkMapViewController *destViewController = segue.destinationViewController;
        destViewController.selectedCarparkInfo = selectedCarpark;
        destViewController.selectedCarparkDetails = selectedCarpark.details;
        destViewController.managedObjectContext = self.managedObjectContext;
        
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"List" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}

@end
