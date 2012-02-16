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

- (void)dealloc
{
    [super dealloc];
}

- (id)init:(long long)itemID
{
    self = [super init];
    if (self)
    {
        addressID = itemID;
    }
    
    return self;
}

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

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithLongLong:addressID] forKey:@"addressID"];
    [aCoder encodeObject:addressName forKey:@"addressName"];
    [aCoder encodeObject:addressBrith forKey:@"addressBrith"];
    [aCoder encodeObject:[NSNumber numberWithBool:addressGender ] forKey:@"addressGender"];
    [aCoder encodeObject:addressAttach forKey:@"addressAttach"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        addressID = [[decoder decodeObjectForKey:@"addessID"] longLongValue];
        addressName = [decoder decodeObjectForKey:@"addressName"];
        addressBrith = [decoder decodeObjectForKey:@"addressBrith"];
        addressGender = [[decoder decodeObjectForKey:@"addressGender"] boolValue];
        addressAttach = [decoder decodeObjectForKey:@"addressAttach"];
    }
    
    return self;
}

- (void)debugOutput
{
    NSString *male = addressGender?@"女":@"男";
    NSLog(@"\n [ID] %lld\n [name] %@\n [brith] %@\n [gender] %@\n [attach] %@", addressID, addressName, addressBrith, male,addressAttach);
}

@end
