//
//  FriendListModel.m
//  DemoApp
//
//  Created by Shi Jin Lu on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KaxinDataSourceModel.h"
#import "CommonData.h"
#import "DataItem.h"
#import "DataItemFactory.h"

#define REQUEST_FRIENDLIST @"https://api.kaixin001.com/friends/me.json"

@implementation KaxinDataSourceModel

@synthesize delegate;
@synthesize friendList;

- (void)dealloc
{
    [requestResponse release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        requestResponse = nil;
    }
    return self;
}

#pragma mark data

- (id)friendList
{
    return [requestResponse objectForKey:@"users"];
}

- (int)dataSourceCount
{
    if ([requestResponse respondsToSelector:@selector(count)])
        return [requestResponse count];
    
    return 0;
}

#pragma mark Friend Info Request

- (id)dataSourceRequest
{
    [[[CommonData sharedData] kaixin] requestWithSeparateURL:REQUEST_FRIENDLIST andHttpMethod:@"GET" andDelegate:self];
    return nil;
}

- (void)request:(KaixinRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"received response");
}

- (void)request:(KaixinRequest *)request didLoad:(id)result
{
    [requestResponse release];
    requestResponse = nil;
    if ([result class] == NSClassFromString(@"__NSCFDictionary")) 
    {
        requestResponse = result;
        [requestResponse retain];
        
        if ([delegate respondsToSelector:@selector(friendListRequestSucess:result:)])
        {
            [delegate friendListRequestSucess:request result:result];
        }
    }
    else
    {
        [self request:request didFailWithError:nil];
    }
}

- (void)request:(KaixinRequest *)request didFailWithError:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(friendListRequestFail:withError:)])
    {
        [delegate friendListRequestFail:request withError:error];
    }
}

- (NSArray*)dataCenterStanderize
{
    NSMutableArray *arry = [NSMutableArray array];
    
    id result = [self friendList];
    if ([result isKindOfClass:[NSArray class]])
    {
        for (id person in result)
        {
            int       personGender  = [[person objectForKey:@"gender"] intValue];
            NSString *personUrl     = [person objectForKey:@"logo50"];
            NSString *personName    = [person objectForKey:@"name"];
            // kaixin uid
            // long long personUid     = [[person objectForKey:@"uid"] longLongValue];
            
            DataItem *dataItem = [DataItemFactory produceDataItem];
            dataItem.addressGender = personGender;
            dataItem.addressName = personName;
            [dataItem addressSetLogoURL:personUrl];
            
            [arry addObject:dataItem];
        }
        
        return arry;
    }
    
    return nil;     
}

@end
