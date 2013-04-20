//
//  XMLParser.m
//  DublinCityParking
//
//  Created by darren cullen on 23/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "XMLParser.h"
#import <BugSense-iOS/BugSenseController.h>


@implementation XMLParser{
    NSXMLParser *parser;
    Carpark *currentCarpark;
}

-(id) loadXMLByURL:(NSString *)urlString
{
    _carparks = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (![elementName isEqualToString:@"carpark"]){
        return;
    }
    
    currentCarpark = [Carpark alloc];
    
    NSString *name = [attributeDict objectForKey:@"name"];
    currentCarpark.name = name;
    
    NSString *spaces = [attributeDict objectForKey:@"spaces"];
    currentCarpark.spaces = spaces;
    
    [self.carparks addObject:currentCarpark];
    currentCarpark = nil; 
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // set up the managedObjectContext to read data from CoreData
    id delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *tmpContext = [[NSManagedObjectContext alloc] init];
    tmpContext.persistentStoreCoordinator = [delegate persistentStoreCoordinator];
    
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"CarparkInfo" inManagedObjectContext:tmpContext];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"code=%@",name]];
    
    NSError *error;
    CarparkInfo *cgCarpark;
    
    cgCarpark = [[tmpContext executeFetchRequest:fetchRequest error:&error] lastObject];
    if ([spaces isEqualToString:@" "]){
        spaces = @"N/A";
    }

    cgCarpark.availableSpaces = spaces;
    error = nil;
    if (![tmpContext save:&error]) {
        NSString *errorMessage = [NSString stringWithFormat:@"Error Saving: Carpark-%@; Spaces:%@",name, spaces];
        [BugSenseController sendCustomEventWithTag:errorMessage];
    }
}


@end
