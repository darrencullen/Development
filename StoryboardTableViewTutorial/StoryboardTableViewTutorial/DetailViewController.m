//
//  DetailViewController.m
//  StoryboardTableViewTutorial
//
//  Created by darren cullen on 22/01/2013.
//  Copyright (c) 2013 DC Development Studios. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *capitalLabel;

@end

@implementation DetailViewController;
@synthesize province = _province;
@synthesize capital = _capital;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self.provinceLabel setText:_province];
    //[self.capitalLabel setText:_capital];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
