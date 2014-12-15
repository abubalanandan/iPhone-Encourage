//
//  JHLocationManager.m
//  Encourage
//

#import "JHLocationManager.h"
#import "JHActivityManager.h"
#import "JHAppDelegate.h"

#define STALE_TIME_CONSTANT 60
#define TVM_LAT 8.48596000
#define TVM_LONG 76.94823833

JHLocationManager * sharedLocation = nil;

@implementation JHLocationManager

@synthesize currentLocation = currentLocation_;
@synthesize isGPSavailable = isGPSavailable_;
@synthesize staleTime = staleTime_;

- (id) init{
    
    self = [super init];
    if (self) {
        
      
        isLocationUpdateAPIInvoked_ = NO;
        locationManager_ = [[CLLocationManager alloc] init];
        
#if TARGET_IPHONE_SIMULATOR
        
        currentLocation_ = [[CLLocation alloc] initWithLatitude:TVM_LAT 
                                                      longitude:TVM_LONG];
        isGPSavailable_ = YES;        
#else
        currentLocation_ = [[CLLocation alloc] init];
        isGPSavailable_ = NO;        
#endif
 
    }
    return self;
}

/** 
 Starts updating location
 */
- (void) startUpdating{
    
    locationManager_.delegate = self;

    [locationManager_ startMonitoringSignificantLocationChanges];
}

/** 
 Stops updating location
 */
- (void) stopUpdating{
    
    [locationManager_ stopUpdatingLocation];
    locationManager_.delegate = nil;
}

- (CLLocation *) getCurrentLocation{
    
      return currentLocation_;
}

#pragma mark -
#pragma mark CLLocationManagerDelegate methods

/*
 Invoked when a new location is available and updates to new location.
 */
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    if (currentLocation_) {
        
        currentLocation_ = nil;
    }
    currentLocation_ = newLocation;
    
    isGPSavailable_ = YES;
}






#pragma mark -
#pragma mark IDCurrentPositionAPIDelegate methods

/**
 If current Position web service fails, no action is performed 
 since it is polled at specific time interval. 
 */
- (void)didFailRequest:(NSString*)error {
    
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
#if TARGET_IPHONE_SIMULATOR    
    isGPSavailable_ = YES;

#else
    
    isGPSavailable_ = NO;
    NSLog(@"%@", [error localizedDescription]);
    
#endif
}

#pragma mark -
#pragma mark Available API delegate method


#pragma mark -
#pragma mark Base API delegate method

/**
 Overriding the delegate methods implemented in BaseViewController.
 Done in case of polling API's.
 **/

- (void)didFailJsonException {
    
    
}


- (void)didRequestTimedOut:(NSString *)error{
    
    
}

- (void)didFailAuthentication:(NSString *)error {



}

- (void)didFailDataFetch:(NSString *)error {
    
    
    
}

- (void)didFailedDataFetch:(NSString *)error{
    
    
    
}

- (void)didRequestFailUnexpectedly {
    
    
}

- (void)didFailNetwork:(NSString *)error {


}


@end
