//
//  AppDelegate.m
//  signifcantChanges
//
//  Created by James Paolantonio on 6/4/12.
//  Copyright (c) 2012 JDub Studios, llc. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*id locationValue = [launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey];
	if (locationValue)
	{
        NSLog(@"UIApplicationLaunchOptionsLocationKey - YES");
	}
    
    BOOL isInBackground = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        isInBackground = YES;
        [self sendBackgroundLocationToServer];
    }*/
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;  
    
    [self.locationManager startUpdatingLocation];
    [self.locationManager startMonitoringSignificantLocationChanges];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    BOOL isInBackground = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        isInBackground = YES;
    }
    NSLog(@"CLLocationCoordinate2D latitude: %f longitude: %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    NSString *baseURL= @"http://example.com/";
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/corelocation.php?latitude=%f&longitude=%f&background=%@&other=%@",
                                                                                  baseURL,
                                                                                  newLocation.coordinate.latitude,
                                                                                  newLocation.coordinate.longitude,
                                                                                  isInBackground ? @"isRunningInBackground" : @"is_NOT_RunningInBackground", 
                                                                                  @"other", nil]]
                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                            timeoutInterval:60.0];
    
    NSLog(@"theRequest: %@", [theRequest URL]);
    
    NSError        *error = nil;
    NSURLResponse  *response = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    
    if (error)
    {
        NSLog(@"Error: %@", error);
    }
    
}

#pragma mark - Background
/*-(void) sendBackgroundLocationToServer;
{
    // REMEMBER. We are running in the background if this is being executed.
    // We can't assume normal network access.
    // bgTask is defined as an instance variable of type UIBackgroundTaskIdentifier
    
    // Note that the expiration handler block simply ends the task. It is important that we always
    // end tasks that we have started.
    
    __block UIBackgroundTaskIdentifier bgTask;
    
    bgTask = [[UIApplication sharedApplication]
              beginBackgroundTaskWithExpirationHandler:
              ^{
                  NSLog(@"BG Task");
                  
                  self.locationManager = [[CLLocationManager alloc] init];
                  self.locationManager.delegate = self;  
                  
                  [self.locationManager startMonitoringSignificantLocationChanges];
                  
                  [[UIApplication sharedApplication] endBackgroundTask:bgTask];
              }];
                  
                  // ANY CODE WE PUT HERE IS OUR BACKGROUND TASK
                  
                  // For example, I can do a series of SYNCHRONOUS network methods (we're in the background, there is
                  // no UI to block so synchronous is the correct approach here).
                  
                  // ...
                  
                  // AFTER ALL THE UPDATES, close the task
                  
    if (bgTask != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }
};*/
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self.locationManager stopUpdatingLocation];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     [self.locationManager stopUpdatingLocation];
}

@end
