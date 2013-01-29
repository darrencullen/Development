//
//  ViewController.h
//  DeveloperAppleTableView
//
//  Created by darren cullen on 24/01/2013.
//  Copyright (c) 2013 DC Development Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *masterRowLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepperValueLabel;

@end
