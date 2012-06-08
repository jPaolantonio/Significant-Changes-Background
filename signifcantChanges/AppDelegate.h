//
//  AppDelegate.h
//  signifcantChanges
//
//  Created by James Paolantonio on 6/4/12.
//  Copyright (c) 2012 JDub Studios, llc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
