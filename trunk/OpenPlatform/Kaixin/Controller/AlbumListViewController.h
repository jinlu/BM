//
//  AlbumListViewController.h
//  DemoApp
//
//  Created by Feng Cheng on 6/7/11.
//  Copyright 2011 kaixin001. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlbumListViewDelegate

@required

- (void)didSelectAlbumAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface AlbumListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    id _albumList;
    
    id<AlbumListViewDelegate> _delegate;
}

- (void)setData:(id)list delegate:(id<AlbumListViewDelegate>)delegate;

@end
