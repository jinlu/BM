
#import "CommonData.h"


@implementation CommonData

@synthesize kaixin, uid;

static CommonData *sharedCommonData = nil;

+ (CommonData*)sharedData
{
    if (sharedCommonData == nil) {
        sharedCommonData = [[super allocWithZone:NULL] init];
    }
    return sharedCommonData;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedData] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (oneway void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end
