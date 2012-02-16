//
//  MyBirthModel.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataItem.h"

@protocol MyBirthDelegate <NSObject>
- (void)myBirthChanged;
@end

@interface MyBirthModel : NSObject 
{
    NSArray                    *myList;
    id <MyBirthDelegate>       delegate;
}

@property (nonatomic, retain) NSArray* myList;
@property (nonatomic, assign) id <MyBirthDelegate> delegate;

- (BOOL)myBrithAdd:(DataItem *)dataItem;
- (BOOL)myBrithRemove:(long long)dataItemId;

@end
