//
//  ViewController.h
//  SampleTableView
//
//  Created by darren cullen on 21/01/2013.
//  Copyright (c) 2013 DC Development Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *contentsList;    
}

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *contentsList;

@end
