//
//  AddBrithModel.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddBrithAdapter.h"

@implementation AddBrithAdapter

+ (BOOL)dataCenterAddBrith:(DataItem *)dataItem
{
    if (dataItem)
    {
        [[DataCenter sharedInstance] dataCenterAdd:dataItem];
        return YES;
    }
    return NO;
}

@end
