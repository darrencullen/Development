//
//  PolyTableViewController.h
//  HelloPoly
//
//  Created by darren cullen on 22/01/2013.
//  Copyright (c) 2013 COMP41550. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"
#import "PolygonView.h"

@interface PolyTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *numberOfSidesLabel;
@property (strong, nonatomic) IBOutlet PolygonShape *model;
@property (strong, nonatomic) IBOutlet PolygonView *polygonView;
@property (weak, nonatomic) IBOutlet UIStepper *stepperSides;
@property (weak, nonatomic) IBOutlet UIView *polygonNameView;
@property (weak, nonatomic) IBOutlet UILabel *polygonName;
@property (weak, nonatomic) IBOutlet UISwitch *switchPolygonName;


- (IBAction)showPolygonName:(UISwitch *)sender;
- (IBAction)stepNumberOfSides:(UIStepper *)sender;
- (IBAction)swipeIncrease:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeDecrease:(UISwipeGestureRecognizer *)sender;

@end
