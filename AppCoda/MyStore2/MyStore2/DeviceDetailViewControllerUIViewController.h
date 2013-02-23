//
//  DeviceDetailViewControllerUIViewController.h
//  MyStore2
//
//  Created by darren cullen on 19/02/2013.
//  Copyright (c) 2013 appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceDetailViewControllerUIViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;

@property (strong) NSManagedObject *device;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end
