
#import "KaixinDialog.h"
#import "KaixinLoginDialog.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation KaixinLoginDialog

///////////////////////////////////////////////////////////////////////////////////////////////////
// public 

- (id)initWithURL:(NSString*) loginURL 
      loginParams:(NSMutableDictionary*) params 
         delegate:(id <KaixinLoginDialogDelegate>) delegate{
  
  self = [super init];
  _serverURL = [loginURL retain];
  _params = [params retain];
  _loginDelegate = delegate;
  return self;
}

- (void) dialogDidSucceed:(NSURL*)url {
    NSString *q = [url absoluteString];
    NSString *token = [KaixinDialog getStringFromUrl:q needle:@"access_token="];
    NSString *refreshToken = [KaixinDialog getStringFromUrl:q needle:@"refresh_token="];
    NSString *expTime = [KaixinDialog getStringFromUrl:q needle:@"expires_in="];
    NSDate *expirationDate =nil;
    
    if (expTime != nil) {
        int expVal = [expTime intValue];
        if (expVal == 0) {
            expirationDate = [NSDate distantFuture];
        } else {
            expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
        } 
    } 
    
    if ((token == (NSString *) [NSNull null]) || (token.length == 0)) {
        [self dialogDidCancel:url];
        [self dismissWithSuccess:NO animated:YES];
    } else {
        if ([_loginDelegate respondsToSelector:@selector(KaixinDialogLogin:refreshToken:expirationDate:)]) {
            [_loginDelegate KaixinDialogLogin:token refreshToken:refreshToken expirationDate:expirationDate];
        }
        [self dismissWithSuccess:YES animated:YES];
    }
	
}

- (void)dialogDidCancel:(NSURL *)url {
  [self dismissWithSuccess:NO animated:YES];
  if ([_loginDelegate respondsToSelector:@selector(KaixinDialogNotLogin:)]) {
    [_loginDelegate KaixinDialogNotLogin:YES];
  }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  if (!(([error.domain isEqualToString:@"NSURLErrorDomain"] && error.code == -999) ||
        ([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102))) {
    [super webView:webView didFailLoadWithError:error];
    if ([_loginDelegate respondsToSelector:@selector(KaixinDialogNotLogin:)]) {
      [_loginDelegate KaixinDialogNotLogin:NO];
    }
  }
}

@end
