//
//  ViewController.m
//  StoryboardTableViewTutorial
//
//  Created by darren cullen on 22/01/2013.
//  Copyright (c) 2013 DC Development Studios. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()
@property (nonatomic) int selectedRow; // our model
@end

@implementation ViewController
@synthesize provinces, datasource;


- (void)viewDidLoad
{
    [self setupArray];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)setupArray
{
    provinces = [[NSMutableDictionary alloc]init];
    [provinces setObject:@"Galway City" forKey:@"Connaught"];
    [provinces setObject:@"Dublin City" forKey:@"Leinster"];
    [provinces setObject:@"Cork City" forKey:@"Munster"];
    [provinces setObject:@"Belfast" forKey:@"Ulster"];
    
    datasource = [provinces allKeys];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [datasource objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {      
        DetailViewController *detailVC = (DetailViewController*)segue.destinationViewController;
        detailVC.province = [datasource objectAtIndex:self.selectedRow];
        NSLog(@"Province: %@", detailVC.province);

        detailVC.capital = [provinces objectForKey:detailVC.province];
        NSLog(@"Capital: %@", detailVC.capital);        
    }
}

@end
