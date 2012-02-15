//
//  AppListViewController.h
//  DemoApp
//
//  Created by kou jun on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *appListTableView;
}

@property (retain, nonatomic) IBOutlet UITableView *appListTableView;

@end
