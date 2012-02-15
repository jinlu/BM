//
//  Address.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataItem : NSObject
{
    long long       addressID;
    NSString        *addressName;
    NSString        *addressBrith;
    BOOL            addressGender;
    NSDictionary    *addressAttach;
}

@property (nonatomic, assign) long long addressID;
@property (nonatomic, copy) NSString* addressName;
@property (nonatomic, copy) NSString* addressBrith;
@property (nonatomic, assign) BOOL addressGender;
@property (nonatomic, assign) NSDictionary* addressAttach;

- (NSString*)addressLogoURL;
- (BOOL)addressSetLogoURL:(NSString *)logoURL;

@end
