//
//  JHLogoutAPI.m
//  Encourage
//
//  Created by Abu on 20/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHLogoutAPI.h"
#import "JHLogoutAPIRequest.h"

@implementation JHLogoutAPI

- (id)init {
    self = [super init];
    if (self) {
        
        baseWebService_.responseClassName = @"JHLogoutAPIResponse";
    }
    return self;
}

-(void)logout{
    [self sendWebserviceRequest];
    JHLogoutAPIRequest *request = [[JHLogoutAPIRequest alloc]init];
    request.token = [JHAppDelegate application].dataManager.token;
    NSString *url = [NSString stringWithFormat:BASE_URL,LOGOUT_URL];
    [baseWebService_ performPostRequest:url withRequestObject:request];
    
}

-(void)didReceiveData:(JHBaseResponse *)responseObj{
    if ([delegate_ respondsToSelector:@selector(loggedOutSuccessfully)]) {
        [delegate_ loggedOutSuccessfully];
    }
    [super didReceiveData:responseObj];
}


-(void)didReceiveNetworkError:(NSString *)errorMessage{
    if (errorMessage==nil) {
        errorMessage = @"Logout Failed";
    }
    [super didReceiveNetworkError:errorMessage];
    if ([delegate_ respondsToSelector:@selector(logoutFailed:)]) {
        [delegate_ logoutFailed:errorMessage];
    }
}
@end
