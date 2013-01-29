//
//  Player.h
//  Ratings
//
//  Created by darren cullen on 23/01/2013.
//  Copyright (c) 2013 DC Development Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *game;
@property (nonatomic, assign) int rating;

@end
