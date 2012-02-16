//
//  AllBrithTableViewCell.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AllBrithTableViewCell.h"
#import "DataItem.h"

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

#pragma mark Cell Info
- (void)setCellInfo:(NSArray*)arry
{
    [personView1 setHidden:YES];
    [personView2 setHidden:YES];
    [personView3 setHidden:YES];
    
    assert([arry count] <= 3);
    if ([arry count] > 0)
    {
        DataItem *dataItem1 = [arry objectAtIndex:0];
        if (dataItem1)
        {
            [personView1 setName:dataItem1.addressName];
            [personView1 setHidden:NO];
        }        
    }
    
    if ([arry count] > 1)
    {
        DataItem *dataItem2 = [arry objectAtIndex:1];
        if (dataItem2)
        {
            [personView2 setName:dataItem2.addressName];
            [personView2 setHidden:NO];
        }
    }
    
    if ([arry count] > 2)
    {
        DataItem *dataItem3 = [arry objectAtIndex:2];
        if (dataItem3)
        {
            [personView3 setName:dataItem3.addressName];
            [personView3 setHidden:NO];
        }        
    }
}

@end
