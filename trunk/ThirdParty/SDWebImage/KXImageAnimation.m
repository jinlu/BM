//
//  KXAnimation.m
//  KaiXinClient
//
//  Created by Shi Jin Lu on 11-12-19.
//  Copyright (c) 2011年 kaixin001. All rights reserved.
//

#import "KXImageAnimation.h"

#define kTransitionDuration	0.75

@implementation KXImageAnimation

+ (void)imageShowScaleAnimation:(UIView *)animationView
{
    CGFloat width = animationView.frame.size.width;
    CGFloat height = animationView.frame.size.height;
    
    animationView.transform = CGAffineTransformMakeScale(1/width, 1/height);
    
    [UIImageView beginAnimations:nil context:nil];
    [UIImageView setAnimationDuration:0.7];
    animationView.transform = CGAffineTransformIdentity;
    [UIImageView commitAnimations];        
}

+ (void)imageShowAnimation:(UIView *)animationView withType:(KXIMAGE_ANIMATION_TYPE)imageAnimationType
{
    if (animationView)
    {
        switch (imageAnimationType) 
        {
            case KXIMAGE_ANIMATION_SCALE:
                [self imageShowScaleAnimation:animationView];
                break;            
            default:
                break;
        }
    }
}

@end
