//
//  DeviceDetailViewController.h
//  MyStore
//
//  Created by darren cullen on 18/02/2013.
//  Copyright (c) 2013 appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *versionTextField;
@property (strong, nonatomic) IBOutlet UITextField *companyTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
