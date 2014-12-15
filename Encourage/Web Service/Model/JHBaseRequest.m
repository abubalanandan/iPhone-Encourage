//
//  JHBaseRequest.m
//  Encourage
//


#import "JHBaseRequest.h"
#import <objc/message.h>
#import "JHAppDelegate.h"


@implementation JHBaseRequest

- (id)init{
    self = [super init];
    if (self){
        CLLocation *location = [[JHAppDelegate application].locationManager getCurrentLocation];
        self.latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        self.longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    }
    return self;
}






@end
