
#import <UIKit/UIKit.h>
#import "KaixinConnect.h"
#import "KaixinLoginButton.h"


@interface DemoAppViewController : UIViewController<KaixinRequestDelegate,KaixinDialogDelegate,KaixinSessionDelegate>
{
    KaixinLoginButton*  _KaixinButton;
    UIButton*           _userPwdLoginButton;
    Kaixin*             _kaixin;
}

@property(nonatomic, retain) IBOutlet KaixinLoginButton*  KaixinButton;
@property(nonatomic, retain) IBOutlet UIButton*           userPwdLoginButton;
@property(readonly) Kaixin *kaixin;

- (IBAction)KaixinButtonClick:(id)sender;
- (IBAction)userPwdLoginButtonClick:(id)sender;
@end
