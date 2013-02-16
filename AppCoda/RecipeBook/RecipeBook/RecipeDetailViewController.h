//
//  RecipeDetailViewController.h
//  RecipeBook
//
//  Created by darren cullen on 16/02/2013.
//  Copyright (c) 2013 appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *recipeLabel;
@property (strong, nonatomic) NSString *recipeName;
@end
