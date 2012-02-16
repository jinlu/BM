//
//  AllBrithTableViewCell.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AllBrithTableViewCell.h"

@implementation AllBrithTableViewCell
@synthesize personView1;
@synthesize personView2;
@synthesize personView3;

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

- (void)dealloc 
{
    [personView1 release];
    [personView2 release];
    [personView3 release];
    [super dealloc];
}
@end
