//
//  Book.h
//  XMLParser
//
//  Created by darren cullen on 23/02/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Book : NSObject {
    
    NSInteger bookID;
    NSString *name; //Same name as the Entity Name.
    NSString *address;      //Same name as the Entity Name.
    NSString *country;      //Same name as the Entity Name.
    
}
@property (nonatomic, readwrite) NSInteger bookID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *country;
@end
