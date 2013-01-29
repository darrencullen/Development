//
//  PolyTableViewCell.m
//  TableViewPoly
//
//  Created by darren cullen on 22/01/2013.
//  Copyright (c) 2013 DC Development Studios. All rights reserved.
//

#import "PolyTableViewCell.h"

@implementation PolyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
