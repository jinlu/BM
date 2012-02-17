//
//  Address.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataItem : NSObject <NSCoding>
{
    // generated by data Item factory
    long long       addressID;
    NSString        *addressName;
    NSString        *addressBrith;
    BOOL            addressGender;
    NSDictionary    *addressAttach;
}

@property (nonatomic, readonly) long long addressID;
@property (nonatomic, copy) NSString* addressName;
@property (nonatomic, copy) NSString* addressBrith;
@property (nonatomic, assign) BOOL addressGender;
@property (nonatomic, assign) NSDictionary* addressAttach;

- (id)init:(long long)itemID;
- (NSString*)addressLogoURL;
- (BOOL)addressSetLogoURL:(NSString *)logoURL;
- (BOOL)addressEqual:(DataItem *)other;
- (void)debugOutput;

@end
