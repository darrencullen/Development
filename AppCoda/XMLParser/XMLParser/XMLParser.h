//
//  XMLParser.h
//  XMLParser
//
//  Created by darren cullen on 23/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMLAppDelegate, Book;

@interface XMLParser : NSObject {
    NSMutableString *currentElementValue;
    
    XMLAppDelegate *appDelegate;
    Book *aBook;
}

- (XMLParser *) initXMLParser;
