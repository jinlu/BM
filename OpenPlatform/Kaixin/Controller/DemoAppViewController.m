

#import "DemoAppViewController.h"
#import "DemoAppAppDelegate.h"
#import "KaixinConnect.h"
#import "CommonData.h"

#import "AppListViewController.h"


@implementation DemoAppViewController

@synthesize kaixin = _kaixin;
@synthesize KaixinButton = _KaixinButton;
@synthesize userPwdLoginButton = _userPwdLoginButton;
//////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

/**
 * initialization
 */
- (id)initWithCoder:(NSCoder*)coder
{
    if (!kAppId) {
        NSLog(@"missing app id!");
        exit(1);
        return nil;
    }
    
    self = [super initWithCoder:coder];
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

/**
 * Show the authorization dialog.
 */
- (void)login {
    [_kaixin authorizeDelegate:self];
    [_kaixin authorizeWithKXAppAuth];
}

-(void)loginUseLocalMode{
    [_kaixin authorizeDelegate:self];
    [_kaixin authorizeWithLocalLoginInView:self.view];
}
/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [_kaixin logout:self];
}

/**
 * Set initial view
 */
- (void)viewDidLoad {
    
	_kaixin = [[Kaixin alloc] initWithAppId:kAppId reDirectURL:kRedirectURL secretKey:kSecretKey];
    [CommonData sharedData].kaixin = _kaixin;
    _KaixinButton.isLoggedIn = NO;
    _KaixinButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_KaixinButton setBackgroundImage:[[UIImage imageNamed:@"loginpage_loginbtn.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
    
    [_KaixinButton updateTitle];
    
    [_userPwdLoginButton setBackgroundImage:[[UIImage imageNamed:@"loginpage_loginbtn.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void)dealloc {
    [_KaixinButton release];
    [_userPwdLoginButton release];
    [_kaixin release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Called on a login/logout button click.
 */
- (IBAction)KaixinButtonClick:(id)sender {
  if (_KaixinButton.isLoggedIn) {
    [self logout];
  } else {
    [self login];
  }
}

- (IBAction)userPwdLoginButtonClick:(id)sender
{
    if (_KaixinButton.isLoggedIn) {
        [self logout];
    } else {
        [self loginUseLocalMode];
    }
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return interfaceOrientation == UIInterfaceOrientationPortrait;
}


/**
 * Called when the user has logged in successfully.
 */
- (void)KaixinDidLogin {
    
    _KaixinButton.isLoggedIn = YES;
    [_KaixinButton updateTitle];
    [_userPwdLoginButton setTitle:@"登出" forState:UIControlStateNormal];
    AppListViewController *appListViewController = [[AppListViewController alloc] initWithNibName:@"AppListViewController" bundle:nil];
    [[self navigationController] pushViewController:appListViewController animated:YES];
    [appListViewController release];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)KaixinDidNotLogin:(BOOL)cancelled {
  NSLog(@"did not login");
}

/**
 * Called when the request logout has succeeded.
 */
- (void)KaixinDidLogout {
    _KaixinButton.isLoggedIn = NO;
    [_KaixinButton updateTitle];
    [_userPwdLoginButton setTitle:@"用户名密码登录" forState:UIControlStateNormal];
}


- (void)request:(KaixinRequest *)request didReceiveResponse:(NSURLResponse *)response {
  NSLog(@"received response");
}

- (void)request:(KaixinRequest *)request didLoad:(id)result
{
    [CommonData sharedData].uid = [[result objectForKey:@"result"] intValue];
    
    _KaixinButton.isLoggedIn = YES;
    [_KaixinButton updateTitle];

};

- (void)request:(KaixinRequest *)request didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError is :%@",  [error localizedDescription]);
};


////////////////////////////////////////////////////////////////////////////////
// KaixinDialogDelegate

/**
 * Called when a UIServer Dialog successfully return.
 */
- (void)dialogDidComplete:(KaixinDialog *)dialog {
}

@end
