//
//  ViewController.h
//  StoryboardTableViewTutorial
//
//  Created by darren cullen on 22/01/2013.
//  Copyright (c) 2013 DC Development Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain)NSMutableDictionary *provinces;
@property(nonatomic, retain)NSArray *datasource;
-(void)setupArray;

@end
