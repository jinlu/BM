//
//  ImportantBrithModel.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataCenter.h"
#import "DataItem.h"


@protocol ImportantBrithDelegate <NSObject>
- (void)importantBirthChanged;
@end

@interface ImportantBrithModel : NSObject <DataCenterDelegate>
{
    NSArray *                   importantList;
    id <ImportantBrithDelegate> delegate;
}

@property (nonatomic, retain) NSArray* importantList;
@property (nonatomic, assign) id <ImportantBrithDelegate> delegate;

- (BOOL)importantBirthAdd:(DataItem *)dataItem;

@end
