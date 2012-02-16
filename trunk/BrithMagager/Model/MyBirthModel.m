//
//  MyBirthModel.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyBirthModel.h"

#import "DataCenter.h"

@implementation MyBirthModel
@synthesize myList;
@synthesize delegate;

- (void)dealloc
{
    [myList release];
    [super dealloc];
}

- (void)checkout
{
    self.myList = [[DataCenter sharedInstance] dataCenterAllPerson];        
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

- (BOOL)myBrithAdd:(DataItem *)dataItem
{
    return NO;
}

- (BOOL)myBrithRemove:(long long)dataItemId
{
    if (dataItemId >= 0)
    {
        [[DataCenter sharedInstance] dataCenterDelete:dataItemId];
    }
    
    return YES;
}
- (void)modelDataModelChanged
{
    [self checkout]; 
    
    if (delegate && [delegate respondsToSelector:@selector(myBirthChanged)])
    {
        [delegate myBirthChanged];
    }
}

@end

