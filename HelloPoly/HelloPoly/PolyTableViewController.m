//
//  PolyTableViewController.m
//  HelloPoly
//
//  Created by darren cullen on 22/01/2013.
//  Copyright (c) 2013 COMP41550. All rights reserved.
//

#import "PolyTableViewController.h"

@interface PolyTableViewController ()

@end

@implementation PolyTableViewController
@synthesize numberOfSidesLabel = _numberOfSidesLabel;
@synthesize model = _model;

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
    self.polygonNameView.backgroundColor = self.polygonView.backgroundColor;
    
    // configure polygon from saved value
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.polygonNameView.hidden = [defaults boolForKey:@"hidePolygonName"];
    self.switchPolygonName.On = ![defaults boolForKey:@"hidePolygonName"];
    
    
    // configure polygon from label
    if (![defaults integerForKey:@"numberOfSides"]){
        self.model.numberOfSides = self.stepperSides.value = [self.numberOfSidesLabel.text integerValue];
    } else {
        self.model.numberOfSides = self.stepperSides.value = [defaults integerForKey:@"numberOfSides"];
    }
    
    [self updatePolygonDisplay];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)stepNumberOfSides:(UIStepper *)sender {
    self.model.numberOfSides = self.stepperSides.value;
    [self updatePolygonDisplay];
}

- (IBAction)swipeIncrease:(UISwipeGestureRecognizer *)sender {
    self.stepperSides.value = self.model.numberOfSides += 1;
    [self updatePolygonDisplay];
}

- (IBAction)swipeDecrease:(UISwipeGestureRecognizer *)sender {
    self.stepperSides.value = self.model.numberOfSides -= 1;
    [self updatePolygonDisplay];
}

- (void)updatePolygonDisplay{
    self.numberOfSidesLabel.text = [NSString stringWithFormat:@"%d", self.model.numberOfSides];
    
    [self.polygonView setNumberOfSides:self.model.numberOfSides];
    self.polygonName.text = self.model.name;
    
    // store number of sides for use in restart
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.model.numberOfSides forKey:@"numberOfSides"];
    
    [self.polygonView setNeedsDisplay];
}


- (IBAction)showPolygonName:(UISwitch *)sender {
    self.polygonNameView.hidden=![sender isOn];
    
    // store name view choice for use in restart
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.polygonNameView.hidden forKey:@"hidePolygonName"];
    
    [self.polygonView setNeedsDisplay];
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
