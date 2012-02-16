//
//  SecondViewController.h
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KaixinLoginController.h"
#import "AddBrithController.h"
#import "AllBrithModel.h"
#import "AllBrithTableViewCell.h"

@interface AllBrithViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    AllBrithModel         *allBrithModel;
    AllBrithTableViewCell *friendInfoCell; 
}

@property (retain, nonatomic) IBOutlet UITableView *allBrithTable;
@property (retain, nonatomic) IBOutlet AllBrithTableViewCell *friendInfoCell;

@end
