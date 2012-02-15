//
//  DataCenter.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataCenter.h"

@interface DataCenter (private)
- (long long)modelDataIDMaker;
@end

@implementation DataCenter
@synthesize delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS(DataCenter);

+ (NSString *)LonglongToString:(long long)value
{
   return [NSString stringWithFormat:@"%lld", value];
}

- (void)dealloc
{
    [observerList release];
    [dataList release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        dataList = [[NSMutableDictionary alloc] init];
        observerList = [[NSMutableArray alloc] init];
    }    
    return self;
}

#pragma mark notification

- (BOOL)addObserver:(id<DataCenterDelegate>)observer
{
    if (observer)
    {
        [observerList addObject:observer];
        return NO;
    }
    return NO;
}

- (BOOL)removeObserver:(id<DataCenterDelegate>)observer
{
    if ([observerList containsObject:observer])
    {
        [observerList removeObject:observer];
        return YES;
    }
    return NO;
}

- (void)dataBaseChange
{
    for (id object in observerList)
    {
        if ([object respondsToSelector:@selector(modelDataModelChanged)])
        {
            [object modelDataModelChanged];
        }
    }    
}

// generate data item id 
- (long long)dataItemIDFactory
{
    long long itemID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"ITEM_ID"] longLongValue];
    NSString *nextItemID = [DataCenter LonglongToString:itemID + 1];
    [[NSUserDefaults standardUserDefaults] setValue:nextItemID forKey:@"ITEM_ID"];
    return itemID;
}

// add data item into data center
- (BOOL)dataCenterAddSilent:(DataItem*)dataItem
{
    if (dataItem != nil)
    {
        long long itemId = [self dataItemIDFactory];
        NSString *stringItemId = [DataCenter LonglongToString:itemId];
        dataItem.addressID = itemId;              
        assert([dataList objectForKey:stringItemId] == nil);        
        [dataList setValue:dataItem forKey:stringItemId];
        return YES;
    }
    
    return NO;
}

// dataCenterAddSilent and notify
- (BOOL)dataCenterAdd:(DataItem*)dataItem
{
    if (dataItem != nil)
    {
        [self dataCenterAddSilent:dataItem];
        [self dataBaseChange];
        return YES;
    }
    
    return NO;
}

// add list to data list
- (BOOL)dataCenterAddList:(NSArray*)dataItemList
{
    if (dataItemList != nil)
    {
        for (DataItem *data in dataItemList)
        {
            [self dataCenterAddSilent:data];
        }
        
        [self dataBaseChange];
        return YES;
    }
    
    return NO;
}

- (BOOL)dataCenterDelete:(long long)dataItemId
{
    NSString *key = [DataCenter LonglongToString:dataItemId];    
    if (dataItemId >= 0)
    {   
        [dataList removeObjectForKey:key];
        [self dataBaseChange];
        return YES;
    }
    
    return NO;
}

- (NSArray*)dataCenterAllPerson
{
    return [dataList allValues];
}

- (void)dataCenterDebugOutput
{
    NSLog(@"\n========Data Center Output=========\n");    
    NSLog(@"%@",dataList);
    NSLog(@"\n===================================\n");    
}

@end
