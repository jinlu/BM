//
//  FriendInfoCell.h
//  DemoApp
//
//  Created by Shi Jin Lu on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendItemCell : UITableViewCell {
    UIImageView *myPhotoImageView;
    UILabel *myNameLabel;
    UILabel *myGenderLabel;
    UILabel *myStatusLabel;
}

@property (nonatomic, retain) IBOutlet UIImageView *myPhotoImageView;
@property (nonatomic, retain) IBOutlet UILabel *myNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *myGenderLabel;
@property (nonatomic, retain) IBOutlet UILabel *myStatusLabel;

@end
