//
//  Monster.h
//  MathMonstersDC
//
//  Created by darren cullen on 05/04/2013.
//  Copyright (c) 2013 dcdevstudios. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Monster;
@protocol MonsterSelectionDelegate <NSObject>
@required
-(void)selectedMonster:(Monster *)newMonster;
@end

typedef enum {
    Blowgun = 0,
    NinjaStar,
    Fire,
    Sword,
    Smoke,
} Weapon;

@interface Monster : NSObject


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, assign) Weapon weapon;

//Factory class method to create new monsters
+(Monster *)newMonsterWithName:(NSString *)name description:(NSString *)description
                      iconName:(NSString *)iconName weapon:(Weapon)weapon;

//Convenience instance method to get the UIImage representing the monster's weapon.
-(UIImage *)weaponImage;
@end
