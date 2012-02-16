//
//  AllBrithModel.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AllBrithModel.h"
#import "DataCenter.h"

@implementation AllBrithModel
@synthesize allList;
@synthesize delegate;

- (void)dealloc
{
    [allList release];
    [super dealloc];
}

// days left
- (void)allBrithCalDayLeft
{
    
}

- (void)checkout
{
    self.allList = [[DataCenter sharedInstance] dataCenterAllPerson];  
    [self allBrithCalDayLeft];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self checkout];
    }
    return self;
}

- (BOOL)allBrithAdd:(DataItem *)dataItem
{
    if (dataItem)
    {
        [[DataCenter sharedInstance] dataCenterAdd:dataItem];
        return NO;
    }
    return NO;
}

- (BOOL)allBrithRemove:(long long)dataItemID
{
    if (dataItemID > 0)
    {
        [[DataCenter sharedInstance] dataCenterDelete:dataItemID];
        return YES;
    }
    return NO;
}

- (void)modelDataModelChanged
{
    [self checkout]; 
    
    if (delegate && [delegate respondsToSelector:@selector(allBirthChanged)])
    {
        [delegate allBirthChanged];
    }
}

@end

