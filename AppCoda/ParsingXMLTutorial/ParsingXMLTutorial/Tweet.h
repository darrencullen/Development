//
//  Tweet.h
//  ParsingXMLTutorial
//
//  Created by darren cullen on 23/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *dateCreated;

@end
