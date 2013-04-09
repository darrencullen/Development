//
//  RightViewController.m
//  MathMonstersDC
//
//  Created by darren cullen on 05/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import "RightViewController.h"
#import "Monster.h"

@implementation RightViewController

- (void)viewDidLoad
{
    [self refreshUI];
    [super viewDidLoad];
}

-(void)setMonster:(Monster *)monster
{
    //Make sure you're not setting up the same monster.
    if (_monster != monster) {
        _monster = monster;
        
        //Update the UI to reflect the new monster on the iPad.
        [self refreshUI];
    }
}

-(void)refreshUI
{
    _nameLabel.text = _monster.name;
    _iconImageView.image = [UIImage imageNamed:_monster.iconName];
    _descriptionLabel.text = _monster.description;
    _weaponImageView.image = [_monster weaponImage];
}

-(void)selectedMonster:(Monster *)newMonster
{
    [self setMonster:newMonster];
}

#pragma mark - IBActions
-(IBAction)chooseColorButtonTapped:(id)sender
{
    if (_colorPicker == nil) {
        //Create the ColorPickerViewController.
        _colorPicker = [[ColorPickerViewController alloc] initWithStyle:UITableViewStylePlain];
        
        //Set this VC as the delegate.
        _colorPicker.delegate = self;
    }
    
    if (_colorPickerPopover == nil) {
        //The color picker popover is not showing. Show it.
        _colorPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_colorPicker];
        [_colorPickerPopover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender
                                    permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        //The color picker popover is showing. Hide it.
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}

#pragma mark - ColorPickerDelegate method
-(void)selectedColor:(UIColor *)newColor
{
    _nameLabel.textColor = newColor;
    
    //Dismiss the popover if it's showing.
    if (_colorPickerPopover) {
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}
@end
