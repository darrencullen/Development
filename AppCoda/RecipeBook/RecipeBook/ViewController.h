//
//  ViewController.h
//  RecipeBook
//
//  Created by darren cullen on 16/02/2013.
//  Copyright (c) 2013 appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
