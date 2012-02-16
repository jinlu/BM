//
//  KXUIImageView.m
//  testImage
//
//  Created by Shi Jin Lu on 11-12-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.

//  11.12.16 jinlu add progress bar


#import "KXUIImageView.h"
#import "UIImageView+WebCache.h"

@interface KXUIImageView (private) 
- (void)initImageProgressView;
@end

@implementation KXUIImageView

@synthesize imageSize;
@synthesize imageAnimationType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self initImageProgressView];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initImageProgressView];
    }
    
    return self;
}

- (void)initImageProgressView
{
    // Initialization code
    imageProgressView = [[[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)] autorelease];
    [imageProgressView setProgressViewStyle:UIProgressViewStyleDefault];
    [imageProgressView setHidden:YES];
    [self addSubview:imageProgressView];      
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url placeholderImage:placeholder options:0];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options 
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    
    self.image = placeholder;
    
    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options];
    }    
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)setImageAnimation:(KXIMAGE_ANIMATION_TYPE)animationType
{
    self.imageAnimationType = animationType;
}

- (void)enableImageProgress:(CGFloat)imageDataSize
{
    self.imageSize = imageDataSize;
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.image = image;    
    
    [imageProgressView setHidden:YES];
    if (imageAnimationType != KXIMAGE_ANIMATION_NONE)
    {
        [KXImageAnimation imageShowAnimation:self withType:self.imageAnimationType];
    }
}

- (void)webImageManager:(SDWebImageManager *)imageManager didRecieveImageData:(NSNumber *)dataSize
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    [imageProgressView setHidden:NO];
    [imageProgressView setFrame:CGRectMake(0, 0 + height / 2.0 , width, 10)];

    imageDownloadedSize = [dataSize intValue];
    
    if (imageSize > 0)
    {
        if ([imageProgressView isHidden])
        {
            [imageProgressView setHidden:NO];
        }

        [imageProgressView setProgress:imageDownloadedSize/imageSize animated:YES];
    }
    else
    {
        [imageProgressView setHidden:YES];
    }
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error 
{
    [imageProgressView setHidden:YES];
}

@end
