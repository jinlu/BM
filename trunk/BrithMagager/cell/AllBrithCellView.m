//
//  AllBrithCellView.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AllBrithCellView.h"

@implementation AllBrithCellView
@synthesize backButton;
@synthesize nameLabel;
@synthesize dayLeftLabel;

- (void)dealloc
{
    [backButton release];
    [nameLabel release];
    [dayLeftLabel release];
    [super dealloc];
}

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

- (void)setDayLeft:(NSString *)dayLeft
{
    [self.dayLeftLabel setText:dayLeft];     
}

- (void)setName:(NSString *)name
{
    [self.nameLabel setText:name];
}


@end
