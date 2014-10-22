//
//  JHLocationManager.h
//  Encourage
//


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JHActivityManager.h"

@interface JHLocationManager : NSObject <CLLocationManagerDelegate>{
    
    CLLocationManager * locationManager_;
    BOOL isLocationUpdateAPIInvoked_;
    NSTimer *currentLocationTimer_;
    NSString *staleTime_;
}

@property (strong, nonatomic) CLLocation * currentLocation;
@property (strong, nonatomic) NSString *staleTime;
@property BOOL isGPSavailable;

- (void) startUpdating;
- (void) stopUpdating;
- (CLLocation *) getCurrentLocation;
- (void) stopCurrentLocationTimer;
@end
