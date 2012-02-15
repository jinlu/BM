//
//  Address.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataItem.h"

@implementation DataItem

@synthesize addressID;
@synthesize addressName;
@synthesize addressBrith;
@synthesize addressGender;
@synthesize addressAttach;

- (BOOL)addressEqual:(DataItem *)other
{
    BOOL ret = YES;
    
    if (self.addressID != other.addressID)
    {
        ret = NO;
    }
    else if (![self.addressName isEqualToString:other.addressName])
    {
        ret = NO;
    }
    else if (![self.addressBrith isEqualToString:other.addressBrith])
    {
        ret = NO;
    }
    else if ((!self.addressGender == other.addressGender))
    {
        ret = NO;
    }
    else if (![self.addressAttach isEqualToDictionary:other.addressAttach])
    {
        ret = NO;
    }
    return ret;    
}

- (NSString*)addressLogoURL
{
    NSString *logoURL = [self.addressAttach objectForKey:@"logoURL"];
    return logoURL;
}

- (BOOL)addressSetLogoURL:(NSString *)logoURL
{
    if (logoURL && [logoURL length] > 0)
    {
        [self.addressAttach setValue:logoURL forKey:@"logoURL"];
        return YES;
    }
    return NO;
}


@end
