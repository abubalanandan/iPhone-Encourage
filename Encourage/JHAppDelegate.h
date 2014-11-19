//
//  JHAppDelegate.h
//  Encourage
//
//  Created by aparna on 01/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHDataManager.h"
#import "JHActivityManager.h"
#import "JHLocationManager.h"




@interface JHAppDelegate : UIResponder <UIApplicationDelegate> {

   
}
/**
 Static function which returns the singleton instance of EncourageAppDelegate  
 */
+ (JHAppDelegate *)application;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JHDataManager *dataManager;
@property (strong, nonatomic) JHLocationManager *locationManager;
@property (strong, nonatomic) JHActivityManager *activityManager;
@property (strong, nonatomic) UINavigationController *navController;





@end
