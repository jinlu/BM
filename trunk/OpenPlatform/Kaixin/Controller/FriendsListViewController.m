

#import "FriendsListViewController.h"
#import "CommonData.h"

@implementation FriendInfoCell
@synthesize photoImageView;
@synthesize nameLabel;
@synthesize genderLabel;
@synthesize statusLabel;

- (void)dealloc
{
    [statusLabel release];
    [photoImageView release];
    [nameLabel release];
    [genderLabel release];

    [super dealloc];
}

@end


@implementation FriendsListViewController

@synthesize friendTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _requestResponse = nil;
    }
    return self;
}

- (void)dealloc
{
    [_requestResponse release];

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
    
    self.navigationItem.title = @"好友列表";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated    // Called when the view is about to made visible. Default does nothing
{
    NSString* requestURL = @"https://api.kaixin001.com/friends/me.json";
    [[[CommonData sharedData] kaixin] requestWithSeparateURL:requestURL andHttpMethod:@"GET" andDelegate:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (_requestResponse == nil)
    {
        return 0;
    }
    else
    {
        if ([_requestResponse respondsToSelector:@selector(count)])
            return [_requestResponse count];
        else
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendInfoCell *cell = (FriendInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"FriendInfoCell"];
    
    if (cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FriendListTableViewCell" owner:self options:nil];
        cell = friendInfoCell;
        friendInfoCell = nil;
    }
    
    int index = [indexPath row];
    id friendList = [_requestResponse objectForKey:@"users"];
    
	if (index >= 0 && index < [friendList count])
	{
        cell.nameLabel.text = [[friendList objectAtIndex:[indexPath row]] objectForKey:@"name"];
        cell.genderLabel.text = ([[[friendList objectAtIndex:[indexPath row]] objectForKey:@"gender"] intValue] == 0 ? @"男" : @"女");
        cell.statusLabel.text = ([[[friendList objectAtIndex:[indexPath row]] objectForKey:@"online"] intValue] == 0 ? @"离线" : @"在线");
    }

    return cell;
}

- (void)request:(KaixinRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"received response");
}

- (void)request:(KaixinRequest *)request didLoad:(id)result
{
    [_requestResponse release];
    _requestResponse = nil;
    if ([result class] == NSClassFromString(@"__NSCFDictionary")) {
        _requestResponse = result;
        [_requestResponse retain];
    }

    [friendTableView reloadData];
}

- (void)request:(KaixinRequest *)request didFailWithError:(NSError *)error
{
    NSString * msg = [[[error userInfo] objectForKey:@"error"] objectForKey:@"msg"];
    
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
