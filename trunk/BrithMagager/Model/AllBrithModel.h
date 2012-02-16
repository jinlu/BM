//
//  AllBrithModel.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataItem.h"
#import "DataCenter.h"

@protocol AllBrithDelegate <NSObject>
- (void)allBirthChanged;
@end

@interface AllBrithModel : NSObject <DataCenterDelegate>
{
    NSMutableDictionary         *allList;
    id <AllBrithDelegate>       delegate;
}

@property (nonatomic, retain) NSMutableDictionary* allList;
@property (nonatomic, assign) id <AllBrithDelegate> delegate;

- (BOOL)allBrithAdd:(DataItem *)dataItem;
- (BOOL)allBrithRemove:(long long)dataItemID;

@end
