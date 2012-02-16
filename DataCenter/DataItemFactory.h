//
//  DataItemFactory.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataItem.h"

@interface DataItemFactory : NSObject

// generate data item id 
+ (DataItem *)produceDataItem;
+ (NSString *)LonglongToString:(long long)value;

@end
