//
//  ViewController.m
//  SampleTableView
//
//  Created by darren cullen on 21/01/2013.
//  Copyright (c) 2013 DC Development Studios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize contentsList;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"Red", @"Blue", @"Green", @"Black", @"Purple", nil];
    [self setContentsList:array];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
    [[self mainTableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[self contentsList] count];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
    NSString *contentForThisRow = [[self contentsList] objectAtIndex:[indexPath row]];
	
    static NSString *CellIdentifier = @"CellIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // Do anything that should be the same on EACH cell here.  Fonts, colors, etc.
    }
	
    // Do anything that COULD be different on each cell here.  Text, images, etc.
    [[cell textLabel] setText:contentForThisRow];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
    NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
}

@end
