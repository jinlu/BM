//
//  UploadPhotoViewController.h
//  testUI
//
//  Created by Feng Cheng on 6/3/11.
//  Copyright 2011 kaixin001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kaixin.h"
#import "AlbumListViewController.h"

@interface UploadPhotoViewController : UIViewController<KaixinRequestDelegate,AlbumListViewDelegate> {
    
    IBOutlet UIImageView * _imageView;

    IBOutlet UIButton* _albumsButton;
    
    id _requestResponse;
    
    int selectedAlbums;
}

- (IBAction)getAlbums:(id)sender;

- (IBAction)upload:(id)sender;

- (void)didSelectAlbumAtIndexPath:(NSIndexPath *)indexPath;

@end
