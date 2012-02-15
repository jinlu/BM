//
//  KaixinLocalLoginDialog.m
//  DemoApp
//
//  Created by kou jun on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "KaixinLocalLoginDialog.h"
#import "JSON.h"
@implementation KaixinLocalLoginDialog

@synthesize delegate = _loginDelegate;
@synthesize params = _params;

- (id)initWithURL:(NSString*) loginURL 
      loginParams:(NSMutableDictionary*) params 
         delegate:(id <KaixinLoginDialogDelegate>) delegate{
    
    if(self = [super initWithFrame:[[UIApplication sharedApplication] keyWindow].frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        userName = [[UITextField alloc] initWithFrame:CGRectMake(60, 40, 200, 30)];
        userName.placeholder = @"输入用户名";
        userName.borderStyle = UITextBorderStyleLine;
        userName.returnKeyType = UIReturnKeyNext;
        userName.enablesReturnKeyAutomatically = YES;
        userName.delegate = self;
        [self addSubview:userName];
        [userName release];
        
        passWord = [[UITextField alloc] initWithFrame:CGRectMake(60, 100, 200, 30)];
        passWord.placeholder = @"输入密码";
        passWord.secureTextEntry = YES;
        passWord.returnKeyType = UIReturnKeyGo;
        passWord.borderStyle = UITextBorderStyleLine;
        passWord.enablesReturnKeyAutomatically = YES;
        passWord.delegate = self;
        [self addSubview:passWord];
        [passWord release];
        
        UIImage* closeImage = [UIImage imageNamed:@"KaixinDialog.bundle/images/close.png"];
        UIColor* color = [UIColor colorWithRed:167.0/255 green:184.0/255 blue:216.0/255 alpha:1];
        _closeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_closeButton setFrame:CGRectMake(260, 20, 30, 30)];
        [_closeButton setImage:closeImage forState:UIControlStateNormal];
        [_closeButton setTitleColor:color forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_closeButton addTarget:self action:@selector(cancel)
               forControlEvents:UIControlEventTouchUpInside];
        
        _closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        
        _closeButton.showsTouchWhenHighlighted = YES;
        _closeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
        | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_closeButton];
        [_closeButton release];
        
        
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                    UIActivityIndicatorViewStyleWhiteLarge];
        _spinner.center = CGPointMake(self.center.x, 80);
        _spinner.hidesWhenStopped = YES;
        _spinner.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
        | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_spinner];
        [_spinner release];
    }
    
    _serverURL = [loginURL retain];
    _params = [params retain];
    _loginDelegate = delegate;
    [userName becomeFirstResponder];
    return self;
}

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
    CGContextBeginPath(context);
    CGContextSaveGState(context);
    
    if (radius == 0) {
        CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddRect(context, rect);
    } else {
        rect = CGRectOffset(CGRectInset(rect, 0.5, 0.5), 0.5, 0.5);
        CGContextTranslateCTM(context, CGRectGetMinX(rect)-0.5, CGRectGetMinY(rect)-0.5);
        CGContextScaleCTM(context, radius, radius);
        float fw = CGRectGetWidth(rect) / radius;
        float fh = CGRectGetHeight(rect) / radius;
        
        CGContextMoveToPoint(context, fw, fh/2);
        CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
        CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
        CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
        CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    }
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    CGContextSaveGState(context);
    static CGFloat fillColors[4] = {0.3, 0.3, 0.3, 0.8};
    CGContextSetFillColor(context, fillColors);
    CGRect rcLogin = CGRectMake(35, 25, 250, 130);
    [self addRoundedRectToPath:context rect:rcLogin radius:5];
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);

    
    CGColorSpaceRelease(space);
}


- (void)dismissWithSuccess:(BOOL)success animated:(BOOL)animated 
{
    [self removeFromSuperview];
}

- (void)dismissWithError:(NSError*)error animated:(BOOL)animated 
{
    [self removeFromSuperview];
}


- (void)connect
{
    [_loadingURL release];
    
    _loadingURL = [[KaixinDialog generateURL:_serverURL params:_params] retain];
    _request = [NSMutableURLRequest requestWithURL:_loadingURL];
    [[NSURLConnection connectionWithRequest:_request delegate:self] start];
    _recData  = [[NSMutableData alloc] init];
    [_spinner startAnimating];
}

-(void)cancel
{
    [_recData release];
    _recData = nil;
    
    [NSURLConnection canHandleRequest:_request];
    [self dismissWithError:nil animated:YES];
    if ([_loginDelegate respondsToSelector:@selector(KaixinDialogNotLogin:)]) {
        [_loginDelegate KaixinDialogNotLogin:YES];
    }
    [_spinner stopAnimating];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_recData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString* q = [[[NSString alloc] initWithData:_recData encoding:NSUTF8StringEncoding] autorelease];
    id json = [q JSONValue];
    NSLog(@"response string:%@",q);
    [_recData release];
    _recData = nil;
    [_spinner stopAnimating];
    
    NSString *token = [json objectForKey:@"access_token"];
    NSString *refreshToken = [json objectForKey:@"refresh_token"];
    NSString *expTime = [json objectForKey:@"expires_in"];
    NSDate *expirationDate =nil;
    
    if (expTime != nil) 
    {
        int expVal = [expTime intValue];
        if (expVal == 0) 
        {
            expirationDate = [NSDate distantFuture];
        }
        else 
        {
            expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
        } 
    } 
    
    if ((token == (NSString *) [NSNull null]) || (token.length == 0)) 
    {
        if ([_loginDelegate respondsToSelector:@selector(KaixinDialogNotLogin:)]) 
        {
            [_loginDelegate KaixinDialogNotLogin:YES];
        }
    } 
    else 
    {
        if ([_loginDelegate respondsToSelector:@selector(KaixinDialogLogin:refreshToken:expirationDate:)]) 
        {
            [_loginDelegate KaixinDialogLogin:token refreshToken:refreshToken expirationDate:expirationDate];
        }
        
    }
    [self dismissWithSuccess:YES animated:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_recData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_recData release];
    _recData = nil;
    [_spinner stopAnimating];
    
    [self dismissWithSuccess:NO animated:YES];
    if ([_loginDelegate respondsToSelector:@selector(KaixinDialogNotLogin:)]) {
        [_loginDelegate KaixinDialogNotLogin:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if (textField == passWord)
    {
        if ([userName.text length] <= 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入用户名" delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return NO;
        }
        else
        {
            [_params setObject:userName.text forKey:@"username"];
            [_params setObject:passWord.text forKey:@"password"];
            [self connect];
            [passWord resignFirstResponder];
            return YES;
        }
    }
    return YES;
}

@end
