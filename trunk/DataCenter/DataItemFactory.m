//
//  DataItemFactory.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataItemFactory.h"
#import "DataItem.h"

@implementation DataItemFactory

+ (NSString *)LonglongToString:(long long)value
{
    return [NSString stringWithFormat:@"%lld", value];
}

+ (long long)dataItemID
{
    long long itemID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"ITEM_ID"] longLongValue];
    NSString *nextItemID = [DataItemFactory LonglongToString:itemID + 1];
    [[NSUserDefaults standardUserDefaults] setValue:nextItemID forKey:@"ITEM_ID"];
    return itemID;
}

+ (DataItem *)produceDataItem
{
    DataItem *dataItem = [[[DataItem alloc] init:[self dataItemID]] autorelease];
    return dataItem;
}

@end
