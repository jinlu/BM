
/**
 * Standard button which lets the user log in or out of the session.
 *
 * The button will automatically change to reflect the state of the session, showing
 * "login" if the session is not connected, and "logout" if the session is connected.
 */
@interface KaixinLoginButton : UIButton {
  BOOL  _isLoggedIn;
}

@property(nonatomic) BOOL isLoggedIn; 

- (void) updateTitle;

@end
