//
//  SecondViewController.m
//  BrithMagager
//
//  Created by Shi Jin Lu on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AllBrithViewController.h"

@implementation AllBrithViewController
@synthesize allBrithTable;
@synthesize friendInfoCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)dealloc
{
    [allBrithModel release];
    [allBrithTable release];
    [friendInfoCell release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"添加生日" style:UIBarButtonItemStylePlain target:self action:@selector(addBrith:)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.title = @"全部生日";
    [leftButton release];
    [rightButton release];
}

- (void)viewDidUnload
{
    [self setAllBrithTable:nil];
    [self setFriendInfoCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (allBrithModel == nil)
    {
        allBrithModel = [[AllBrithModel alloc] init];
        [allBrithModel setDelegate:self];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark Naviagation Bar

- (void)edit:(id)sender
{
    
}

- (void)addBrith:(id)sender
{
    AddBrithController *addBrithController = [AddBrithController sharedInstance];
    [self.navigationController pushViewController:addBrithController animated:YES];
}

#pragma mark UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allBrithModel.allList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllBrithTableViewCell *cell = (AllBrithTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FriendInfoCell"];
    if (cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"PersonViewCell" owner:self options:nil];
        cell = friendInfoCell;
        friendInfoCell = nil;
    }
    
    int index = [indexPath row];    
    id friendList = allBrithModel.allList;     
    id cellInfo = [friendList objectForKey:[NSNumber numberWithInt:index]];
    [cell setCellInfo:cellInfo];
    return cell;
}

#pragma mark UITableView Data Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124;
}


#pragma mark Model Delegate
- (void)allBirthChanged
{
    [allBrithTable reloadData];
}

@end
