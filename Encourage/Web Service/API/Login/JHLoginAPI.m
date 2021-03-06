//
//  JHLoginAPI.m
//  Encourage
//
//  Created by Abu on 22/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHLoginAPI.h"
#import "JHLoginAPIRequest.h"
#import "JHLoginAPIResponse.h"

@implementation JHLoginAPI

- (id)init {
    self = [super init];
    if (self) {
        
        baseWebService_.responseClassName = @"JHLoginAPIResponse";
    }
    return self;
}


- (void)performLogin:(JHLoginAPIRequest *)request{
    [self sendWebserviceRequest];
    NSString *url = [NSString stringWithFormat:BASE_URL,LOGIN_URL];
    [baseWebService_ performPostRequest:url withRequestObject:request];
}

- (void)didReceiveData:(JHBaseResponse *)responseObj{

    if ([delegate_ respondsToSelector:@selector(didReceiveLoginDetails:)]) {
        [delegate_ didReceiveLoginDetails:(JHLoginAPIResponse *)responseObj];
    }
    [super didReceiveData:responseObj];
}

- (void)didReceiveNetworkError:(NSString *)errorMessage{
    [super didReceiveNetworkError:errorMessage];
    if (errorMessage==nil) {
        errorMessage = @"Failed to Login. Please try again";
    }
    if ([delegate_ respondsToSelector:@selector(loginFailed:)]) {
        [delegate_ loginFailed:errorMessage];
    }
}

@end
