//
//  CarparkDetalsDescriptionViewController.m
//  DublinCityParking
//
//  Created by darren cullen on 14/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "CarparkDetalsDescriptionViewController.h"

@interface CarparkDetalsDescriptionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CarparkDetalsDescriptionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.title;    
    self.details = [self.details stringByReplacingOccurrencesOfString: @"&#xA;" withString: @"\n"];
                        
    self.textView.text = self.details;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
