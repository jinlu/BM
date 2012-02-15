
#import "KaixinLoginButton.h"
#import "Kaixin.h"

#import <dlfcn.h>

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation KaixinLoginButton

@synthesize isLoggedIn = _isLoggedIn;

- (void)updateTitle {
	if (_isLoggedIn) {
		[self setTitle:@"登 出" forState:UIControlStateNormal];
	} else {
		[self setTitle:@"WebView登录" forState:UIControlStateNormal];
	}
}

@end 
