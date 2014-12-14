//
//  JHBaseAPI.m
//  Encourage
//

#import "JHBaseAPI.h"
#import "JHResponeMessage.h"
#import "JHError.h"
#import "JHAppDelegate.h"

@implementation JHBaseAPI

@synthesize delegate = delegate_;

- (id) init {
    self = [super init];
    if(self) {
        baseWebService_ = [[JHWebService alloc] init];
        baseWebService_.delegate = self; 
    } 
    return self;
}

- (void) sendWebserviceRequest {
    
    [[JHAppDelegate application].activityManager startPleaseWaitActivityIndicator];
}

#pragma mark - Basewebservice delegate methods

- (void)didReceiveData:(JHBaseResponse *)responseObj {
    
    [[JHAppDelegate application].activityManager stopPleaseWaitActivityIndicator];
}

- (void)didRequestFailAuthentication:(JHResponeMessage *)message {

    [[JHAppDelegate application].activityManager stopPleaseWaitActivityIndicator];
    if([delegate_ respondsToSelector:@selector(didFailAuthentication:)])
        [delegate_ didFailAuthentication:[message errorDescription]];
    [self didReceiveNetworkError:message.errorDescription];
}

- (void)didReceiveJSONException {
    
    [[JHAppDelegate application].activityManager stopPleaseWaitActivityIndicator];
    if([delegate_ respondsToSelector:@selector(didFailJsonException)])
        [delegate_ didFailJsonException];
    [self didReceiveNetworkError:nil];
    
}

- (void)didFailUnexpectedly {
    
    [[JHAppDelegate application].activityManager stopPleaseWaitActivityIndicator];
    if([delegate_ respondsToSelector:@selector(didRequestFailUnexpectedly)])
        [delegate_ didRequestFailUnexpectedly];
    [self didReceiveNetworkError:nil];
}

- (void)requestTimedOut:(NSString *)error {

    [[JHAppDelegate application].activityManager stopPleaseWaitActivityIndicator];
    if([delegate_ respondsToSelector:@selector(didRequestTimedOut:)])
        [delegate_ didRequestTimedOut:error];
    [self didReceiveNetworkError:error];
}


- (void)didReceiveNetworkError:(NSString *)errorMessage {

    [[JHAppDelegate application].activityManager stopPleaseWaitActivityIndicator];
    if([delegate_ respondsToSelector:@selector(didFailNetwork:)])
        [delegate_ didFailNetwork:errorMessage];

}

- (void)didReceiveFailedStatusCode:(JHResponeMessage*)message {
    
    [[JHAppDelegate application].activityManager stopPleaseWaitActivityIndicator];
    if (message == nil || [message errorDescription]== nil || message == (id)[NSNull null] ||[message errorDescription] == (id)[NSNull null]) {
        
        if([delegate_ respondsToSelector:@selector(didFailNullException)])
            [delegate_ didFailNullException];
        
    }
  
    if([delegate_ respondsToSelector:@selector(didFailDataFetch:)])
        [delegate_ didFailDataFetch:[message errorDescription]];
    [self didReceiveNetworkError:message.errorDescription];
}

- (void)didRequestFailDataFetch:(JHResponeMessage *)message {
    
    [[JHAppDelegate application].activityManager stopPleaseWaitActivityIndicator];
    if([delegate_ respondsToSelector:@selector(didFailedDataFetch)])
        [delegate_ didFailedDataFetch:[message errorDescription]];
    [self didReceiveNetworkError:message];
}

- (void)dealloc {
	
    baseWebService_.delegate = nil;
	[baseWebService_ release];
    if (delegate_)
		delegate_ = nil;
    [super dealloc];
}

@end
