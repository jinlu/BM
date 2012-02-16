#import <UIKit/UIKit.h>
#import "DemoAppViewController.h"


/*
 * kAppId : 申请组件时获得的API Key
 * kSecretKey : 申请组件时获得的Secret Key
 * kRedirectURL : 申请组件获得的网址
 */
static NSString* kAppId = @"406817719384260f3a500c535433a973"; //@"391539743237928ea711a484a5d4c513";
static NSString* kSecretKey = @"2f6b4bae2406ade1787bac979c9b0220";//@"cdabd96b3c9684befb85a02cd02bf8a5";
static NSString* kRedirectURL = @"http://localhost/";

@interface DemoAppAppDelegate : NSObject <UIApplicationDelegate> 
{

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *viewController;

@end

@interface KXNavigationBar : UINavigationBar
@end