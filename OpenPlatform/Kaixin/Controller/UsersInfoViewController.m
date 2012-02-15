

#import "UsersInfoViewController.h"
#import "CommonData.h"


@implementation UsersInfoViewController
@synthesize imageView;
@synthesize nameLabel;
@synthesize uidLabel;
@synthesize genderLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString* requestURL = @"https://api.kaixin001.com/users/me.json";
        [[[CommonData sharedData] kaixin] requestWithSeparateURL:requestURL andHttpMethod:@"GET" andDelegate:self];        
    }
    return self;
}

- (void)dealloc
{    
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{    
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 30)];
    [btn setBackgroundImage:[[UIImage imageNamed:@"backbutton.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0,6, 0, 0);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:btn] autorelease];
    [btn release];
    
    self.navigationItem.title = @"个人资料";
}

- (void)request:(KaixinRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"received response");
}

- (void)request:(KaixinRequest *)request didLoad:(id)result
{
    [self.nameLabel setText: [NSString stringWithFormat:@"姓名：%@", [result objectForKey:@"name"]]];
    [self.uidLabel setText: [NSString stringWithFormat:@"ID：%@", [result objectForKey:@"uid"]]];
    [self.genderLabel setText: [NSString stringWithFormat:@"性别：%@", [[result objectForKey:@"gender"]intValue] == 0 ? @"男" : @"女"]];
        
    NSURL * imgURL = [NSURL URLWithString:[result objectForKey:@"logo50"]];
    NSData * imgData = [NSData dataWithContentsOfURL:imgURL];
    UIImage * imgHead = [[UIImage alloc] initWithData:imgData];
    [self.imageView setImage: imgHead];
    
}


//- (void)request:(KaixinRequest *)request didFailWithError:(NSError *)error
//{
//    NSString * msg = [[[error userInfo] objectForKey:@"error"] objectForKey:@"msg"];
//};

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
