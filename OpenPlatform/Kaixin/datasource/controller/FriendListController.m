//
//  FriendList.m
//  DemoApp
//
//  Created by Shi Jin Lu on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendListController.h"
#import "CommonData.h"

@implementation FriendListController
@synthesize friendTableView;
@synthesize friendInfoCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        
    }
    return self;
}

- (void)dealloc
{    
    [friendInfoCell release];
    [friendTableView release];
    [super dealloc];
}

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
        
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 30)];
    [btn setBackgroundImage:[[UIImage imageNamed:@"backbutton.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0,6, 0, 0);
    [btn setTitle:@"全部添加" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addAll:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:btn] autorelease];
    [btn release];
    
    self.navigationItem.title = @"好友列表";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.friendInfoCell = nil;
    self.friendTableView = nil;
}

- (void)viewWillAppear:(BOOL)animated    // Called when the view is about to made visible. Default does nothing
{
    if (dataModel == nil)
    {
        dataModel = [[KaxinDataSourceModel alloc] init];
        [dataModel setDelegate:self];
    }
    
    [dataModel dataSourceRequest];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (dataModel == nil)
    {
        return 0;
    }
    else
    {
        if ([dataModel respondsToSelector:@selector(dataSourceCount)])
            return [dataModel dataSourceCount];
        else
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendItemCell *cell = (FriendItemCell *)[tableView dequeueReusableCellWithIdentifier:@"FriendInfoCell"];
    
    if (cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FriendItemTableViewCell" owner:self options:nil];
        cell = friendInfoCell;
        friendInfoCell = nil;
    }
    
    int index = [indexPath row];
    
    id friendList = [dataModel friendList]; 
    
	if (index >= 0 && index < [friendList count])
	{        
        cell.myNameLabel.text = [[friendList objectAtIndex:[indexPath row]] objectForKey:@"name"];
        cell.myGenderLabel.text = ([[[friendList objectAtIndex:[indexPath row]] objectForKey:@"gender"] intValue] == 0 ? @"男" : @"女");
        cell.myStatusLabel.text = ([[[friendList objectAtIndex:[indexPath row]] objectForKey:@"online"] intValue] == 0 ? @"离线" : @"在线");
    }
    
    return cell;
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addAll:(id)sender
{
    [dataModel dataCenterCheckin];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark FriendRequest 

-(BOOL)friendListRequestSucess:(KaixinRequest *)request result:(id)result
{
    [friendTableView reloadData];
    return YES;
}

-(BOOL)friendListRequestFail:(KaixinRequest *)request withError:(NSError *)error
{
    NSString * msg = [[[error userInfo] objectForKey:@"error"] objectForKey:@"msg"];
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alert show];
	[alert release];    
    return YES;
}

@end
