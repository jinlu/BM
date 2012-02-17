//
//  DataSourceBase.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataSourceBase.h"
#import "DataCenter.h"

@implementation DataSourceBase

- (BOOL)dataCenterContain:(DataItem *)dataItem
{
    BOOL ret = NO;
    NSArray *allPerson = [[DataCenter sharedInstance] dataCenterAllPerson];
    
    for (id person in allPerson)
    {
        if ([person isKindOfClass:[DataItem class]])
        {
            if ([(DataItem *)person addressEqual:dataItem])
            {
                ret = YES;
                break;
            }
        }
    }
    
    return ret;
}

// get data source 
- (NSArray*)dataCenterSource
{
    return nil;
}

// data source into data center
- (BOOL)dataCenterCheckin
{
    NSArray *data = [self dataCenterStanderize];
    NSArray *dataNoDuplicate = [self dataCenterFilter:data];
    [[DataCenter sharedInstance] dataCenterAddList:dataNoDuplicate];
    return YES;
}

// data source standerize
- (NSArray*)dataCenterStanderize
{
    return nil;    
}

// remove duplicate
- (NSArray*)dataCenterFilter:(NSArray*)rawList
{
    NSMutableArray *result = [NSMutableArray array];

    if (rawList)
    {
        for (id rawData in rawList)
        {
            if ([rawData isKindOfClass:[DataItem class]])
            {
                if (![self dataCenterContain:rawData])
                {
                    [result addObject:rawData];
                }
            }
        }
        return result;
    }
    
    return nil;
}

@end
