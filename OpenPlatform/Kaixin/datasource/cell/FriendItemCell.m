//
//  FriendInfoCell.m
//  DemoApp
//
//  Created by Shi Jin Lu on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendItemCell.h"
#import "CommonData.h"

@implementation FriendItemCell
@synthesize myPhotoImageView;
@synthesize myNameLabel;
@synthesize myGenderLabel;
@synthesize myStatusLabel;

- (void)dealloc
{
    [myStatusLabel release];
    [myPhotoImageView release];
    [myNameLabel release];
    [myGenderLabel release];
    
    [super dealloc];
}

@end