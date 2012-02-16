//
//  FriendListModel.h
//  DemoApp
//
//  Created by Shi Jin Lu on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KaixinRequest.h"
#import "DataSourceBase.h"

@protocol FriendListModelDelegate <NSObject>
-(BOOL)friendListRequestSucess:(KaixinRequest *)request result:(id)result;
-(BOOL)friendListRequestFail:(KaixinRequest *)request withError:(NSError *)error;
@end

@interface KaxinDataSourceModel : DataSourceBase <KaixinRequestDelegate>
{
    id                              requestResponse;
    id <FriendListModelDelegate>    delegate;
    id                              friendList;
}

@property(nonatomic,assign) id <FriendListModelDelegate> delegate;
@property(nonatomic,readonly) id friendList;

// init
- (id)init;

// request
- (id)dataSourceRequest;

// count
- (int)dataSourceCount;

@end
