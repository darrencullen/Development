//
//  TrafficCamerasViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 12/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "TrafficCamerasViewController.h"
#import "TrafficCameraInfo.h"

@interface TrafficCamerasViewController ()

@property (nonatomic, strong) TrafficCameraInfo *selectedCamera;
@property (nonatomic, strong) NSMutableArray *trafficCamerasD1;
@property (nonatomic, strong) NSMutableArray *trafficCamerasD2;
@property (nonatomic, strong) NSMutableArray *trafficCameraLocations;

@end

@implementation TrafficCamerasViewController


// TODO: optimisation on initialisation required????
- (void) setTrafficCameras:(NSArray *)trafficCameras
{
    if (_trafficCameras != trafficCameras)
        _trafficCameras = trafficCameras;
}

- (NSMutableArray *)trafficCamerasD1
{
    if (!_trafficCamerasD1) {
        _trafficCamerasD1 = [[NSMutableArray alloc] init];
    } return _trafficCamerasD1;
}

- (NSMutableArray *)trafficCamerasD2
{
    if (!_trafficCamerasD2) {
        _trafficCamerasD2 = [[NSMutableArray alloc] init];
    } return _trafficCamerasD2;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    
    // TODO: MOVE ARRAYS TO MODEL NSOBJECT
    self.trafficCamerasD1 = [[NSMutableArray alloc] init];
    self.trafficCamerasD2 = [[NSMutableArray alloc] init];
    self.trafficCameraLocations = [[NSMutableArray alloc] initWithObjects:self.trafficCamerasD1, self.trafficCamerasD2, nil];
    
    // set up the managedObjectContext to read data from CoreData
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TrafficCameraInfo"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError *error;
    self.trafficCameras = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (TrafficCameraInfo *camera in self.trafficCameras){
        if ([camera.postCode isEqualToString:@"D1"]){
            [self.trafficCamerasD1 addObject:camera];
        } else if ([camera.postCode isEqualToString:@"D2"]){
            [self.trafficCamerasD2 addObject:camera];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.trafficCameraLocations.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.    
    NSArray *sectionContents = [self.trafficCameraLocations objectAtIndex:section];
    NSInteger rows = [sectionContents count];
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: maybe use region as a cell identifier
    static NSString *CellIdentifier = @"TrafficCameraCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *selectedSection = self.trafficCameraLocations[indexPath.section];
    self.selectedCamera = [selectedSection objectAtIndex:[indexPath row]];
    
    UILabel *trafficCameraStreetLabel = (UILabel *)[cell viewWithTag:300];
    trafficCameraStreetLabel.text = self.selectedCamera.name;
    
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
    NSArray *selectedSection = self.trafficCameraLocations[indexPath.section];
    self.selectedCamera = [selectedSection objectAtIndex:[indexPath row]];
    
    // do a segue based on the indexPath or do any setup later in prepareForSegue
    [self performSegueWithIdentifier:@"showTrafficCameraMap" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *selectedSection = self.trafficCameraLocations[indexPath.section];
    self.selectedCamera = [selectedSection objectAtIndex:[indexPath row]];
    
    // do a segue based on the indexPath or do any setup later in prepareForSegue
    [self performSegueWithIdentifier:@"showTrafficCameraMap" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"showTrafficCameraMap"]){
        
        //        DisabledSpaceMapViewController *destViewController = segue.destinationViewController;
        //        destViewController.selectedDisabledSpaceInfo = self.selectedSpace;
        //
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"List" style: UIBarButtonItemStyleBordered target: nil action: nil];
        
        [[self navigationItem] setBackBarButtonItem: newBackButton];
    }
}


@end
