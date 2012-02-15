//
//  KaixinLocalLoginDialog.h
//  DemoApp
//
//  Created by kou jun on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KaixinLoginDialog.h"

@interface KaixinLocalLoginDialog : UIView<UITextFieldDelegate>
{
    id<KaixinLoginDialogDelegate> _loginDelegate; 
    NSMutableDictionary           *_params;
    NSURL                         *_loadingURL;
    NSURLRequest                  *_request;
    
    NSString        *_serverURL;
    NSMutableData   *_recData;
    
    UITextField *userName;
    UITextField *passWord;
    UIButton    *_closeButton;
    UIActivityIndicatorView *_spinner;
    
}
/**
 * The delegate.
 */
@property(nonatomic,assign) id<KaixinLoginDialogDelegate> delegate;

/**
 * The parameters.
 */
@property(nonatomic, retain) NSMutableDictionary* params;


- (id)initWithURL:(NSString*) loginURL 
      loginParams:(NSMutableDictionary*) params 
         delegate:(id <KaixinLoginDialogDelegate>) delegate;
@end
