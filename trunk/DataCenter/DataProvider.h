//
//  DataProvider.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataItem.h"

@protocol DataProvider <NSObject>

// get data source
- (NSArray*)dataCenterSource; 

// data source standerize
- (NSArray*)dataCenterStanderize;

// data source into data center
- (BOOL)dataCenterCheckin;

// data source remove duplicate
- (NSArray*)dataCenterFilter:(NSArray*)data;

@end
