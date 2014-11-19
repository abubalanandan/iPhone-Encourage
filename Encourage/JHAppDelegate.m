
#import "JHAppDelegate.h"
#import "JHLoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation JHAppDelegate

JHAppDelegate *mainApplicationInstance_;

@synthesize window = window_;
@synthesize dataManager = dataManager_;
@synthesize activityManager = activityManager_;
@synthesize locationManager = locationManager_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    mainApplicationInstance_ = self;
    dataManager_ = [[JHDataManager alloc] init];
    activityManager_ = [[JHActivityManager alloc] init];
    locationManager_ = [[JHLocationManager alloc] init];
    [locationManager_ startUpdating];
    JHLoginViewController *splashViewController = [[JHLoginViewController alloc]
                                    initWithNibName:@"JHLoginViewController" bundle:nil];

    _navController = [[UINavigationController alloc]initWithRootViewController:
                             splashViewController]; 
    window_.rootViewController = _navController;
    [window_ makeKeyAndVisible];
      

        
    return YES;
}


+ (JHAppDelegate *)application {
    
	return mainApplicationInstance_;
}






/**
 If upgrade fails, then the user can use the existing version of the app 
 and can retry it next time, the app is launched.
 */
- (void)didRequestTimedOut:(NSString *)error{
}

- (void)didFailAuthentication:(NSString *)error  {
    
    
}

- (void)didFailJsonException  {
    
}

- (void)didRequestFailUnexpectedly {
    
   
}

- (void)didFailDataFetch:(NSString *)error {
    
}


- (void)didFailNetwork:(NSString *)error {
    
    
}

- (void)didFailNullException {
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
        /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
   
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
