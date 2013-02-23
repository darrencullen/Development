//
//  FBCMasterViewController.h
//  FailedBankCD
//
//  Created by darren cullen on 20/02/2013.
//  Copyright (c) 2013 wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCMasterViewController : UITableViewController
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, strong) NSArray *failedBankInfos;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end
