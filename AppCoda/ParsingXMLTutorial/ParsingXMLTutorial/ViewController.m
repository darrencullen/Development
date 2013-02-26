//
//  ViewController.m
//  ParsingXMLTutorial
//
//  Created by darren cullen on 23/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "ViewController.h"
#import "XMLParser.h"

@interface ViewController ()

@end

@implementation ViewController{
    XMLParser *xmlParser;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    xmlParser = [[XMLParser alloc] loadXMLByURL:@"http://www.dublincity.ie/dublintraffic/cpdata.xml"];
    //xmlParser = [[XMLParser alloc] loadXMLByURL:@"http://api.twitter.com/1/statuses/user_timeline/kentfranks.xml"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
