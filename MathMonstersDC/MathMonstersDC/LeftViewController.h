//
//  LeftViewController.h
//  MathMonstersDC
//
//  Created by darren cullen on 05/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Monster.h"

@interface LeftViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *monsters;
@property (nonatomic, assign) id<MonsterSelectionDelegate> delegate;

@end
