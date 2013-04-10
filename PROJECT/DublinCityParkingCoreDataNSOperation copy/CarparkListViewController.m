//
//  DCDMasterViewController.m
//  DublinCityParkingCoreData
//
//  Created by darren cullen on 21/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CarparkListViewController.h"
#import "CarparkInfo.h"
#import "CarparkDetails.h"
#import "XMLParser.h"
#import "CarparkMapViewController.h"

@interface CarparkListViewController ()
// @property (nonatomic, strong) CarParkLots *carParkLots;
// TODO: construct arrays in separate nsobject 
@property (nonatomic, strong) XMLParser *xmlParser;
@property (nonatomic, strong) CarparkInfo *selectedCarpark;
@property (nonatomic, strong) NSMutableArray *southeastCarparks;
@property (nonatomic, strong) NSMutableArray *southwestCarparks;
@property (nonatomic, strong) NSMutableArray *northeastCarparks;
@property (nonatomic, strong) NSMutableArray *northwestCarparks;
@property (nonatomic, strong) NSMutableArray *carparkLocations;

@end

@implementation CarparkListViewController


// TODO: optimisation on initialisation required????
- (void) setCarparkInfos:(NSArray *)carparkInfos
{
    if (_carparkInfos != carparkInfos)
        _carparkInfos = carparkInfos;
}

- (NSMutableArray *)southeastCarparks
{
    if (!_southeastCarparks) {
        _southeastCarparks = [[NSMutableArray alloc] init];
    } return _southeastCarparks;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    
    // TODO: MOVE ARRAYS TO MODEL NSOBJECT
    self.southwestCarparks = [[NSMutableArray alloc] init];
    self.northeastCarparks = [[NSMutableArray alloc] init];
    self.northwestCarparks = [[NSMutableArray alloc] init];
    self.carparkLocations = [[NSMutableArray alloc] initWithObjects:self.southeastCarparks, self.southwestCarparks, self.northeastCarparks, self.northwestCarparks, nil];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CarparkInfo"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError *error;
    self.carparkInfos = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (CarparkInfo *carpark in self.carparkInfos){
        if ([carpark.details.region isEqualToString:@"Southeast"]){
            [self.southeastCarparks addObject:carpark];
        } else if ([carpark.details.region isEqualToString:@"Southwest"]){
            [self.southwestCarparks addObject:carpark];
        } else if ([carpark.details.region isEqualToString:@"Northeast"]){
            [self.northeastCarparks addObject:carpark];
        } else if ([carpark.details.region isEqualToString:@"Northwest"]){
            [self.northwestCarparks addObject:carpark];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadXMLData)
                                                 name:@"appDidBecomeActive"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contextChanged:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
}

- (void)contextChanged:(NSNotification*)notification
{
    // update managed object on main thread when edited on background thread
    if ([notification object] == [self managedObjectContext]) return;
    
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(contextChanged:) withObject:notification waitUntilDone:YES];
        return;
    }
    
    [[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
}

- (void) viewWillAppear:(BOOL)animated
{
  //  [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self loadXMLData];
    NSLog(@"viewDidAppear");
}


- (void) loadXMLData {
	NSLog(@"loadXMLData");
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
	NSOperationQueue *queue = [NSOperationQueue new];
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(loadXMLDataWithOperation)
																			  object:nil];
	[queue addOperation:operation];
}

- (void) loadXMLDataWithOperation {
    self.xmlParser = [[XMLParser alloc] loadXMLByURL:@"http://www.dublincity.ie/dublintraffic/cpdata.xml"];
	
    [self performSelectorOnMainThread:@selector(reloadUpdatedData) withObject:nil waitUntilDone:YES];
    
	//[self.tableView performSelectorOnMainThread:@selector(reloadUpdatedData) withObject:nil waitUntilDone:YES];
}

- (void) reloadUpdatedData
{
  //  [self updateSpaces];
    [self.carparkList reloadData];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

//- (void) updateSpaces
//{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"CarparkInfo" inManagedObjectContext:self.managedObjectContext];
//    
//    
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    self.carparkInfos = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    for (CarparkInfo *carpark in self.carparkInfos){
////        if ([carpark.details.region isEqualToString:@"Southeast"]){
////            [southeastCarparks addObject:carpark];
////        } else if ([carpark.details.region isEqualToString:@"Southwest"]){
////            [southwestCarparks addObject:carpark];
////        } else if ([carpark.details.region isEqualToString:@"Northeast"]){
////            [northeastCarparks addObject:carpark];
////        } else if ([carpark.details.region isEqualToString:@"Northwest"]){
////            [northwestCarparks addObject:carpark];
////        }
//        NSLog(@"Code: %@", carpark.code);
//        NSLog(@"Spaces: %@", carpark.availableSpaces);
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.carparkLocations.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [self.carparkInfos count];
    
    NSArray *sectionContents = [self.carparkLocations objectAtIndex:section];
    NSInteger rows = [sectionContents count];
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    // TODO: maybe use region as a cell identifier
    static NSString *CellIdentifier = @"CarparkCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *selectedSection = self.carparkLocations[indexPath.section];
    self.selectedCarpark = [selectedSection objectAtIndex:[indexPath row]];
    //selectedCarpark = [self.carparkInfos objectAtIndex:indexPath.row];
    
   // NSLog(@"%ld;%ld;%@", (long)indexPath.section, (long)indexPath.row, selectedCarpark.name);
    
    UILabel *carparkNameLabel = (UILabel *)[cell viewWithTag:100];
    carparkNameLabel.text = self.selectedCarpark.name;
    
    UILabel *carparkAddressLabel = (UILabel *)[cell viewWithTag:101];
    carparkAddressLabel.text = [NSString stringWithFormat:@"%@", self.selectedCarpark.address];
    
    UILabel *availableSpacesLabel = (UILabel *)[cell viewWithTag:102];
    availableSpacesLabel.text = self.selectedCarpark.availableSpaces;
    
//    CarparkDetails *details;
//    details = selectedCarpark.details;
//    NSLog(@"Code: %@", [selectedCarpark valueForKey:@"code"]);
//    NSLog(@"Region: %@", [details valueForKey:@"region"]);
//    NSLog(@"Rate1: %@", [details valueForKey:@"otherRate1"]);
//    NSLog(@"Directions: %@", [details valueForKey:@"directions"]);
//    NSLog(@"Services: %@", [details valueForKey:@"services"]);
//    NSLog(@"TotalSpaces: %@", [details valueForKey:@"totalSpaces"]);
    
    return cell;
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
        headerLabel.text = @"Southeast";
    else if(section == 1)
        headerLabel.text = @"Southwest";
    else if(section == 2)
        headerLabel.text = @"Northeast";
    else
        headerLabel.text = @"Northwest";
    
    [headerView addSubview:headerLabel];
    return headerView;
    
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
    NSArray *selectedSection = self.carparkLocations[indexPath.section];
    self.selectedCarpark = [selectedSection objectAtIndex:[indexPath row]];
    
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
        destViewController.selectedCarparkInfo = self.selectedCarpark;
        
//        NSLog(@"Code: %@", selectedCarpark.code);
//        NSLog(@"AvailableSpaces: %@", selectedCarpark.availableSpaces);
        
//        destViewController.selectedCarparkDetails = selectedCarpark.details;
//        destViewController.managedObjectContext = self.managedObjectContext;
        
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"List" style: UIBarButtonItemStyleBordered target: nil action: nil];

//        UIImage *barBackBtnImg = [[UIImage imageNamed:@"button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//        
//        [newBackButton setBackButtonBackgroundImage:barBackBtnImg
//                                                          forState:UIControlStateNormal
//                                                        barMetrics:UIBarMetricsDefault];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.managedObjectContext = nil;
}

@end
