//
//  ListViewController.h
//  ClassicPhotos
//
//  Created by darren cullen on 02/03/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

#define kDatasourceURLString @"http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist"

@interface ListViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *photos;

@end
