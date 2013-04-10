//
//  DisabledSpacesViewController.m
//  DublinCityParkingCoreDataNSOperation
//
//  Created by darren cullen on 10/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "DisabledSpacesViewController.h"
#import "DisabledParkingSpaceInfo.h"

@interface DisabledSpacesViewController ()

@property (nonatomic, strong) DisabledParkingSpaceInfo *selectedSpace;
@property (nonatomic, strong) NSMutableArray *disabledSpacesD1;
@property (nonatomic, strong) NSMutableArray *disabledSpacesD2;
@property (nonatomic, strong) NSMutableArray *disabledSpaceLocations;

@end

@implementation DisabledSpacesViewController


// TODO: optimisation on initialisation required????
- (void) setCarparkInfos:(NSArray *)carparkInfos
{
    if (_disabledSpaces != carparkInfos)
        _disabledSpaces = carparkInfos;
}

- (NSMutableArray *)disabledSpacesD1
{
    if (!_disabledSpacesD1) {
        _disabledSpacesD1 = [[NSMutableArray alloc] init];
    } return _disabledSpacesD1;
}

- (NSMutableArray *)disabledSpacesD2
{
    if (!_disabledSpacesD2) {
        _disabledSpacesD2 = [[NSMutableArray alloc] init];
    } return _disabledSpacesD2;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
/*
    // TODO: MOVE ARRAYS TO MODEL NSOBJECT
    self.disabledSpacesD1 = [[NSMutableArray alloc] init];
    self.disabledSpacesD2 = [[NSMutableArray alloc] init];
    self.disabledSpaceLocations = [[NSMutableArray alloc] initWithObjects:self.disabledSpacesD1, self.disabledSpacesD2, nil];
    
    // set up the managedObjectContext to read data from CoreData
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DisabledParkingSpaceInfo"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError *error;
    self.disabledSpaces = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (DisabledParkingSpaceInfo *space in self.disabledSpaces){
        if ([space.postCode isEqualToString:@"D1"]){
            [self.disabledSpacesD1 addObject:space];
        } else if ([space.postCode isEqualToString:@"D2"]){
            [self.disabledSpacesD2 addObject:space];
        }
    }
 */
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

//- (void) loadXMLDataWithOperation {
//    self.xmlParser = [[XMLParser alloc] loadXMLByURL:@"http://www.dublincity.ie/dublintraffic/cpdata.xml"];
//	
//    [self performSelectorOnMainThread:@selector(reloadUpdatedData) withObject:nil waitUntilDone:YES];
//    
//	//[self.tableView performSelectorOnMainThread:@selector(reloadUpdatedData) withObject:nil waitUntilDone:YES];
//}
//
//- (void) reloadUpdatedData
//{
//    //  [self updateSpaces];
//    [self.carparkList reloadData];
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.disabledSpaces.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [self.carparkInfos count];
    
    NSArray *sectionContents = [self.disabledSpaces objectAtIndex:section];
    NSInteger rows = [sectionContents count];
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: maybe use region as a cell identifier
    static NSString *CellIdentifier = @"DisabledSpaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *selectedSection = self.disabledSpaces[indexPath.section];
    self.selectedSpace = [selectedSection objectAtIndex:[indexPath row]];
    
    UILabel *disabledSpaceStreetLabel = (UILabel *)[cell viewWithTag:200];
    disabledSpaceStreetLabel.text = self.selectedSpace.street;
    
    UILabel *spacesLabel = (UILabel *)[cell viewWithTag:201];
    spacesLabel.text = self.selectedSpace.spaces;
    
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
        headerLabel.text = @"Dublin 1";
    else if(section == 1)
        headerLabel.text = @"Dublin 2";
    
    [headerView addSubview:headerLabel];
    return headerView;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSArray *selectedSection = self.disabledSpaces[indexPath.section];
    self.selectedSpace = [selectedSection objectAtIndex:[indexPath row]];
    
    // do a segue based on the indexPath or do any setup later in prepareForSegue
    [self performSegueWithIdentifier:@"showDisabledSpaceMap" sender:self];
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
        
//        DisabledSpaceMapViewController *destViewController = segue.destinationViewController;
//        destViewController.selectedDisabledSpaceInfo = self.selectedSpace;
//        
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"List" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}


@end
