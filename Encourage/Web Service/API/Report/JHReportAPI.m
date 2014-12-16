//
//  JHReportAPI.m
//  Encourage
//
//  Created by kiran vs on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHReportAPI.h"

@implementation JHReportAPI

- (id)init {
    self = [super init];
    if (self) {
        
        baseWebService_.responseClassName = @"JHReportAPIResponse";
    }
    return self;
}


- (void)sendReport:(JHReportAPIRequest *)request {
    
    [self sendWebserviceRequest];
    request.dateTime = [Utility getFormattedDate];
    request.token = [JHAppDelegate application].dataManager.token;
    NSString *url = [NSString stringWithFormat:BASE_URL,REPORT_URL];
    [baseWebService_ performPostRequest:url withRequestObject:request];
}

- (void)didReceiveData:(JHBaseResponse *)responseObj{
    
    if ([delegate_ respondsToSelector:@selector(didReceiveReportResponse:)]) {
        [delegate_ didReceiveReportResponse:(JHReportAPIResponse *)responseObj];
    }
    [super didReceiveData:responseObj];
}

- (void)didReceiveNetworkError:(NSString *)errorMessage{
    if (errorMessage==nil) {
        errorMessage = @"Report posting failed. Please try again.";
        
    }
    if ([delegate_ respondsToSelector:@selector(failedToPostReport:)]) {
        [delegate_ failedToPostReport:errorMessage];
    }
}
@end
