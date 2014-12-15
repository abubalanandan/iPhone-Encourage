//
//  JHAlertsAPI.m
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHAlertsAPI.h"

@implementation JHAlertsAPI

- (id)init {
    self = [super init];
    if (self) {
        
        baseWebService_.responseClassName = @"JHAlertsAPIResponse";
    }
    return self;
}

- (void)getAlertDetails:(NSString *)token andLastCount:(int)lastCount {
        
    NSString *url = [NSString stringWithFormat:BASE_URL,ALERT_DETAILS_URL];
    JHAlertsAPIRequest *request = [[JHAlertsAPIRequest alloc]init];
    request.token = token;
    request.dateTime = [Utility getFormattedDate];
    request.timeZone =  [[NSTimeZone localTimeZone]name];
    if (lastCount>0) {
        request.start = lastCount;
    }
    
    [baseWebService_ performPostRequest:url withRequestObject:request];
}


- (void)didReceiveData:(JHBaseResponse *)responseObj{
    if ([delegate_ respondsToSelector:@selector(didReceiveAlertsDetails:)]) {
        [delegate_ didReceiveAlertsDetails:(JHAlertsAPIResponse *)responseObj];
    }
    [super didReceiveData:responseObj];
}

@end
