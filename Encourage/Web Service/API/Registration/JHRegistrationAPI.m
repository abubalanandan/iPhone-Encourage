//
//  JHRegistrationAPI.m
//  Encourage
//
//  Created by Abu on 14/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHRegistrationAPI.h"
#import "JHRegistrationAPIRequest.h"
#import "JHRegistrationAPIResponse.h"

@implementation JHRegistrationAPI
- (id)init {
    self = [super init];
    if (self) {
        
        baseWebService_.responseClassName = @"JHRegistrationAPIResponse";
    }
    return self;
}


- (void)registerUser:(NSString *)firstName :(NSString *)lastName :(NSString *)emailAddress{
    
    [self sendWebserviceRequest];
    
    JHRegistrationAPIRequest *request = [[JHRegistrationAPIRequest alloc]init];
    request.dateTime = [Utility getFormattedDate];
    request.timeZone = [NSTimeZone localTimeZone].name;
    request.fName = firstName;
    request.lName = lastName;
    request.emailAddress = emailAddress;
    
    NSString *url = [NSString stringWithFormat:BASE_URL,REGISTRATION_URL];
    [baseWebService_ performPostRequest:url withRequestObject:request];
    
    
}

- (void)didReceiveData:(JHBaseResponse *)responseObj{
    if ([delegate_ respondsToSelector:@selector(didRegisterUserSuccessfully)]){
        [delegate_ didRegisterUserSuccessfully];
    }
    [super didReceiveData:responseObj];
}

- (void)didReceiveNetworkError:(NSString *)errorMessage{
    [super didReceiveNetworkError:errorMessage];
    if ([delegate_ respondsToSelector:@selector(userRegistrationFailed:)]) {
        [delegate_ userRegistrationFailed:errorMessage];
    }
}

@end
