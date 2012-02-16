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
    [[DataCenter sharedInstance] removeObserver:self];
    [allList release];
    [super dealloc];
}

// days left
- (void)allBrithCalDayLeft
{
    
}

- (void)dataListForController:(NSArray *)list
{
    int row = 0;    
    NSMutableArray *array = [NSMutableArray array];
    for (id data in list)
    {
        [array addObject:data];        
        if ([array count] == 3)
        {
            [allList setObject:array forKey:[NSNumber numberWithInt:row]];
            array = [NSMutableArray array];
            row++;
        }
    }    
    
    if ([array count] != 0)
    {
        [allList setObject:array forKey:[NSNumber numberWithInt:row]];
    }
    
    NSLog(@"\n all list : %@", allList);
}

- (void)checkout
{
    NSArray *list = [[DataCenter sharedInstance] dataCenterAllPerson];  
    [self dataListForController:list];
    [self allBrithCalDayLeft];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        allList = [[NSMutableDictionary alloc] init];
        [[DataCenter sharedInstance] addObserver:self];
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

