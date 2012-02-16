//
//  KXAnimation.h
//  KaiXinClient
//
//  Created by Shi Jin Lu on 11-12-19.
//  Copyright (c) 2011年 kaixin001. All rights reserved.
//

#import "SynthesizeSingleton.h"
#import <Foundation/Foundation.h>

typedef enum
{
    KXIMAGE_ANIMATION_NONE = 0,
    KXIMAGE_ANIMATION_SCALE = 1,
}KXIMAGE_ANIMATION_TYPE;

@interface KXImageAnimation : NSObject
{
    

}

+ (void)imageShowAnimation:(UIView *)animationView withType:(KXIMAGE_ANIMATION_TYPE)imageAnimationType;
+ (void)imageShowScaleAnimation:(UIView *)animationView;

@end

