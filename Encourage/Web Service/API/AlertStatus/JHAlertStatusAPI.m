//
//  JHAlertStatusAPI.m
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHAlertStatusAPI.h"

@implementation JHAlertStatusAPI
- (id)init {
    self = [super init];
    if (self) {
        
        baseWebService_.responseClassName = @"JHAlertStatusAPIResponse";
    }
    return self;
}


-(void)markAlertAsRead:(NSString *)alertKey{
    JHAlertStatusAPIRequest *request = [[JHAlertStatusAPIRequest alloc]init];
    request.dateTime = [Utility getFormattedDate];
    request.timeZone = [[NSTimeZone localTimeZone]name];
    request.alertKey = alertKey;
    request.token = [JHAppDelegate application].dataManager.token;
    NSString *url = [NSString stringWithFormat:BASE_URL,UPDATE_ALERT_STATUS_URL];
    [baseWebService_ performPostRequest:url withRequestObject:request];
}

- (void)didReceiveData:(JHBaseResponse *)responseObj{
    [super didReceiveData:responseObj];
    if ([delegate_ respondsToSelector:@selector(markedAlertSuccessfully)]) {
        [delegate_ markedAlertSuccessfully];
    }
}

-(void)didReceiveNetworkError:(NSString *)errorMessage{
    if (errorMessage==nil) {
        errorMessage = @"Failed to update Alert Status. Please try again.";
    }
    if ([delegate_ respondsToSelector:@selector(failedToMarkAlert:)]) {
        [delegate_ failedToMarkAlert:errorMessage];
    }
    [super didReceiveNetworkError:errorMessage];
}
@end
