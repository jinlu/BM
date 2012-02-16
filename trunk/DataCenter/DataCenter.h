//
//  DataCenter.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "DataItem.h"

@protocol DataCenterDelegate <NSObject>
@required
- (void)modelDataModelChanged;
@end

@interface DataCenter : NSObject
{
    NSMutableDictionary       *dataList;
    NSMutableArray            *observerList;
}

@property (nonatomic, assign)id <DataCenterDelegate> delegate;

// add observer
- (BOOL)addObserver:(id<DataCenterDelegate>)observer;

// remove observer
- (BOOL)removeObserver:(id<DataCenterDelegate>)observer;

// add data item into data center
- (BOOL)dataCenterAdd:(DataItem*)dataItem;

// add data items into data center
- (BOOL)dataCenterAddList:(NSArray*)dataItemList;

// remove data items in data center
- (BOOL)dataCenterDelete:(long long)dataItemId;

// data list all value
- (NSArray *)dataCenterAllPerson;

- (void)dataCenterDebugOutput;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(DataCenter)

@end
