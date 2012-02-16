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

// get data source 
- (NSArray*)dataCenterSource
{
    return nil;
}

// data source into data center
- (BOOL)dataCenterCheckin
{
    NSArray *data = [self dataCenterStanderize];
    [[DataCenter sharedInstance] dataCenterAddList:data];
    return YES;
}

// data source standerize
- (NSArray*)dataCenterStanderize
{
    return nil;    
}

@end
