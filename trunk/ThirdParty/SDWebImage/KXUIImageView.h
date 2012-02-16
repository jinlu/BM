//
//  KXUIImageView.h
//  testImage
//
//  Created by Shi Jin Lu on 11-12-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import "SDWebImageCompat.h"
#import "SDWebImageManagerDelegate.h"
#import "SDWebImageManager.h"
#import <UIKit/UIKit.h>
#import "KXImageAnimation.h"

//With Animation, progress bar 

@interface KXUIImageView : UIImageView <SDWebImageManagerDelegate>
{
    CGFloat  imageSize;    
    CGFloat  imageDownloadedSize;

    UIProgressView         *imageProgressView;
    KXIMAGE_ANIMATION_TYPE imageAnimationType;
}

@property(nonatomic,assign) CGFloat imageSize;
@property(nonatomic,assign) KXIMAGE_ANIMATION_TYPE imageAnimationType;

- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options;
- (void)cancelCurrentImageLoad;

- (void)setImageAnimation:(KXIMAGE_ANIMATION_TYPE)AnimationType;
- (void)enableImageProgress:(CGFloat)imageDataSize;

@end
