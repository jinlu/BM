

#import "DemoAppAppDelegate.h"
#import "DemoAppViewController.h"

@implementation DemoAppAppDelegate

@synthesize window=_window;

@synthesize viewController=_viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end

@implementation KXNavigationBar
-(void)drawRect:(CGRect)rect {
	[[UIImage imageNamed:@"titlebg2.png"] drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end