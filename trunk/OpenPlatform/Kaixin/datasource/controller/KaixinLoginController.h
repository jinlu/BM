//
//  KaixinLogin.h
//  DemoApp
//
//  Created by Shi Jin Lu on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KaixinConnect.h"
#import "KaixinLoginButton.h"
#import "SynthesizeSingleton.h"
#import "KaixinLoginController.h"

@interface KaixinLoginController : UIViewController<KaixinRequestDelegate,KaixinDialogDelegate,KaixinSessionDelegate>
{
    KaixinLoginButton       *KaixinButton;
    UIButton                *userPwdLoginButton;
    Kaixin                  *kaixin;
}

@property(nonatomic, retain) IBOutlet KaixinLoginButton*  KaixinButton;
@property(nonatomic, retain) IBOutlet UIButton*           userPwdLoginButton;
@property(readonly) Kaixin *kaixin;

- (IBAction)KaixinButtonClick:(id)sender;
- (IBAction)userPwdLoginButtonClick:(id)sender;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(KaixinLoginController)

@end