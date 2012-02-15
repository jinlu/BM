//
//  AlbumListViewController.m
//  DemoApp
//
//  Created by Feng Cheng on 6/7/11.
//  Copyright 2011 kaixin001. All rights reserved.
//

#import "AlbumListViewController.h"


@implementation AlbumListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
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
    self.navigationItem.title = @"相册列表";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setData:(id)list delegate:(id<AlbumListViewDelegate>)delegate
{
    _albumList = list;
    _delegate = delegate;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_albumList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *kCellIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier] autorelease];
	}
	
    cell.textLabel.text = [[_albumList objectAtIndex:[indexPath row]] objectForKey:@"title"];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self navigationController] popViewControllerAnimated:YES];
    [_delegate didSelectAlbumAtIndexPath:indexPath];
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
