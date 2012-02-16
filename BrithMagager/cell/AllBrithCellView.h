//
//  AllBrithCellView.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllBrithCellView : UITableViewCell
{
    UIButton *backButton;
    UILabel  *nameLabel;
    UILabel  *dayLeftLabel;
}

- (void)setDayLeft:(NSString *)dayLeft;
- (void)setName:(NSString *)name;

@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *dayLeftLabel;

@end
