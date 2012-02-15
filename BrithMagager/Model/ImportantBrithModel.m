//
//  ImportantBrithModel.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImportantBrithModel.h"

@implementation ImportantBrithModel
@synthesize importantList;
@synthesize delegate;

- (void)dealloc
{
    [importantList release];
    [super dealloc];
}

- (void)checkout
{
    self.importantList = [[DataCenter sharedInstance] dataCenterAllPerson];        
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

- (BOOL)importantBirthAdd:(DataItem *)dataItem
{
    return NO;
}

- (void)modelDataModelChanged
{
    [self checkout]; 
    
    if (delegate && [delegate respondsToSelector:@selector(importantBirthChanged)])
    {
        [delegate importantBirthChanged];
    }
}

@end
