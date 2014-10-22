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
    NSString *url = @"http://tryencourage.com/hwdsi/encservice/userLogin.php";
    [baseWebService_ performPostRequest:url withRequestObject:request];
}

- (void)didReceiveData:(JHBaseResponse *)responseObj{
    if ([delegate_ respondsToSelector:@selector(didReceiveLoginDetails:)]) {
        [delegate_ didReceiveLoginDetails:(JHLoginAPIResponse *)responseObj];
    }
    [super didReceiveData:responseObj];
}

@end
