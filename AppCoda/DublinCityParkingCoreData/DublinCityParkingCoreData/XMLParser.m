//
//  XMLParser.m
//  ParsingXMLTutorial
//
//  Created by darren cullen on 23/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser{
//    NSMutableString *currentNodeContent;
    NSXMLParser *parser;
    Carpark *currentCarpark;
//    bool isStatus;
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

//- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
//{
//    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (![elementName isEqualToString:@"carpark"]){
        return;
    }
    
    currentCarpark = [Carpark alloc];
//    isStatus = YES;
    
    NSString *name = [attributeDict objectForKey:@"name"];
    currentCarpark.name = name;
    
    NSString *spaces = [attributeDict objectForKey:@"spaces"];
    currentCarpark.spaces = spaces;
    
    [self.carparks addObject:currentCarpark];
    currentCarpark = nil; 
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"CarparkInfo" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"Name=%@",name]];
    
    [fetchRequest setEntity:entity];
    NSError *error;
    CarparkInfo *cgCarpark;
    
    cgCarpark = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    
    cgCarpark.availableSpaces = spaces;
    error = nil;
    if (![self.managedObjectContext save:&error]) {
        //Handle any error with the saving of the context
    }
  
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

    if ([elementName isEqualToString:@"carparkData"]){
        for (Carpark *foundCarpark in self.carparks){
            NSLog(@"Name: %@; Spaces: %@", foundCarpark.name, foundCarpark.spaces);
        }
    }
}

@end
