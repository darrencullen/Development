//
//  StaticTableViewController.h
//  Ratings
//
//  Created by darren cullen on 24/01/2013.
//  Copyright (c) 2013 DC Development Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticTableViewController : UITableViewController
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *masterRowLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderValueLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

- (IBAction)logHello;
- (IBAction)sliderValueChanged:(UISlider *)slider;
@end
