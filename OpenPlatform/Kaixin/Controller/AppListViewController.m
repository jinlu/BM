//
//  AppListViewController.m
//  DemoApp
//
//  Created by kou jun on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppListViewController.h"

#import "FriendsListViewController.h"
#import "UsersInfoViewController.h"
#import "UploadPhotoViewController.h"

@implementation AppListViewController
@synthesize appListTableView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 30)];
    [btn setBackgroundImage:[[UIImage imageNamed:@"backbutton.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0,6, 0, 0);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:btn] autorelease];
    [btn release];
    
    self.navigationItem.title = @"应用列表";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.appListTableView = nil;
}

- (void)dealloc {
    [appListTableView release];
    [super dealloc];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    NSString* ret = @"";
    switch (section)
    {
        case 0:
            ret = @"个人信息";
            break;
        case 1:
            ret = @"上传照片";
            break;
        default:
            break;
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 2;
        case 1:
            return 1;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"appListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"我的资料";
        }
        else
        {
            cell.textLabel.text = @"好友列表";
        }
    }
    else if(indexPath.section == 1)
    {
        cell.textLabel.text = @"上传照片";
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {            
            UsersInfoViewController *usersInfoViewController = [[UsersInfoViewController alloc]
                                                                initWithNibName:@"UsersInfoViewController" bundle:nil];
            
            [[self navigationController] pushViewController:usersInfoViewController animated:YES];
            
            [UsersInfoViewController release];        
        }
        else
        {
            FriendsListViewController *friendsListViewController = [[FriendsListViewController alloc]
                                                                    initWithNibName:@"FriendsListViewController" bundle:nil];
            
            [[self navigationController] pushViewController:friendsListViewController animated:YES];
            
            [friendsListViewController release];        
            
        }
    }
    else
    {
        UploadPhotoViewController *uploadViewController = [[UploadPhotoViewController alloc] initWithNibName:@"UploadPhotoViewController" bundle:nil];
        [[self navigationController] pushViewController:uploadViewController animated:YES];
        [uploadViewController release];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
