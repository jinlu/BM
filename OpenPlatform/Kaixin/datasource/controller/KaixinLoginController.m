//
//  KaixinLogin.m
//  DemoApp
//
//  Created by Shi Jin Lu on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KaixinLoginController.h"
#import "DemoAppViewController.h"
#import "DemoAppAppDelegate.h"
#import "KaixinConnect.h"
#import "CommonData.h"
#import "FriendListController.h"

@implementation KaixinLoginController

SYNTHESIZE_SINGLETON_FOR_CLASS(KaixinLoginController)

@synthesize kaixin;
@synthesize KaixinButton;
@synthesize userPwdLoginButton;
//////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

/**
 * initialization
 */
- (id)initWithCoder:(NSCoder*)coder
{
    if (!kAppId) 
    {
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
- (void)login 
{
    [kaixin authorizeDelegate:self];
    [kaixin authorizeWithKXAppAuth];
}

-(void)loginUseLocalMode
{
    [kaixin authorizeDelegate:self];
    [kaixin authorizeWithLocalLoginInView:self.view];
}
/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout 
{
    [kaixin logout:self];
}

/**
 * Set initial view
 */
- (void)viewDidLoad 
{    
	kaixin = [[Kaixin alloc] initWithAppId:kAppId reDirectURL:kRedirectURL secretKey:kSecretKey];
    [CommonData sharedData].kaixin = kaixin;
    KaixinButton.isLoggedIn = NO;
    KaixinButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [KaixinButton setBackgroundImage:[[UIImage imageNamed:@"loginpage_loginbtn.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
    
    [KaixinButton updateTitle];
    
    [userPwdLoginButton setBackgroundImage:[[UIImage imageNamed:@"loginpage_loginbtn.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void)dealloc 
{
    [KaixinButton release];
    [userPwdLoginButton release];
    [kaixin release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Called on a login/logout button click.
 */
- (IBAction)KaixinButtonClick:(id)sender 
{
    if (KaixinButton.isLoggedIn) 
    {
        [self logout];
    } else {
        [self login];
    }
}

- (IBAction)userPwdLoginButtonClick:(id)sender
{
    if (KaixinButton.isLoggedIn) 
    {
        [self logout];
    } 
    else 
    {
        [self loginUseLocalMode];
    }
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}


/**
 * Called when the user has logged in successfully.
 */
- (void)KaixinDidLogin 
{
    KaixinButton.isLoggedIn = YES;
    [KaixinButton updateTitle];
    [userPwdLoginButton setTitle:@"登出" forState:UIControlStateNormal];
    FriendListController *appListViewController = [[FriendListController alloc] initWithNibName:@"FriendListController" bundle:nil];
    [[self navigationController] pushViewController:appListViewController animated:YES];
    [appListViewController release];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)KaixinDidNotLogin:(BOOL)cancelled 
{
    NSLog(@"did not login");
}

/**
 * Called when the request logout has succeeded.
 */
- (void)KaixinDidLogout 
{
    KaixinButton.isLoggedIn = NO;
    [KaixinButton updateTitle];
    [userPwdLoginButton setTitle:@"用户名密码登录" forState:UIControlStateNormal];
}


- (void)request:(KaixinRequest *)request didReceiveResponse:(NSURLResponse *)response 
{
    NSLog(@"received response");
}

- (void)request:(KaixinRequest *)request didLoad:(id)result
{
    [CommonData sharedData].uid = [[result objectForKey:@"result"] intValue];
    
    KaixinButton.isLoggedIn = YES;
    [KaixinButton updateTitle];
    
};

- (void)request:(KaixinRequest *)request didFailWithError:(NSError *)error 
{
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
