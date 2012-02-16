
#import <Foundation/Foundation.h>
#import "Kaixin.h"


@interface CommonData : NSObject
{
    Kaixin * kaixin;
    int uid;
}

@property(nonatomic,assign) Kaixin * kaixin;

@property(nonatomic,assign) int uid;

+ (CommonData*)sharedData;

@end
