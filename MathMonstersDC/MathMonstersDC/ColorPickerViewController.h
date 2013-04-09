//
//  ColorPickerViewController.h
//  MathMonstersDC
//
//  Created by darren cullen on 07/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate <NSObject>
@required
-(void)selectedColor:(UIColor *)newColor;
@end

@interface ColorPickerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *colorNames;
@property (nonatomic, weak) id<ColorPickerDelegate> delegate;
@end