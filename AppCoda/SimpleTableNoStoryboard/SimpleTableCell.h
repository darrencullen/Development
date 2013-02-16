//
//  SimpleTableCell.h
//  SimpleTableNoStoryboard
//
//  Created by darren cullen on 16/02/2013.
//  Copyright (c) 2013 appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;


@end
