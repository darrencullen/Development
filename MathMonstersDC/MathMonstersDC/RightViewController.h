//
//  RightViewController.h
//  MathMonstersDC
//
//  Created by darren cullen on 05/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Monster.h"
#import "ColorPickerViewController.h"


@class Monster;
@interface RightViewController : UIViewController <MonsterSelectionDelegate, UISplitViewControllerDelegate, ColorPickerDelegate>

@property (nonatomic, strong) Monster *monster;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIImageView *weaponImageView;

@property (nonatomic, strong) ColorPickerViewController *colorPicker;
@property (nonatomic, strong) UIPopoverController *colorPickerPopover;

-(IBAction)chooseColorButtonTapped:(id)sender;
@end
