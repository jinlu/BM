//
//  FriendList.h
//  DemoApp
//
//  Created by Shi Jin Lu on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kaixin.h"
#import "FriendItemCell.h"
#import "KaxinDataSourceModel.h"
#import "SynthesizeSingleton.h"

@interface FriendListController : UIViewController <UITableViewDelegate, UITableViewDataSource, FriendListModelDelegate> 
{
    UITableView             *friendTableView;
    FriendItemCell          *friendInfoCell;
    KaxinDataSourceModel    *dataModel;
}

@property (nonatomic, retain) IBOutlet FriendItemCell * friendInfoCell;
@property (nonatomic, retain) IBOutlet UITableView * friendTableView;

@end