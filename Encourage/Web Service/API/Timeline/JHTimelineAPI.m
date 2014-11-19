//
//  JHTimelineAPI.m
//  Encourage
//
//  Created by Abu on 12/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHTimelineAPI.h"
#import "JHTimelineAPIRequest.h"
#import "Utility.h"

@implementation JHTimelineAPI

- (id)init {
    self = [super init];
    if (self) {
        
        baseWebService_.responseClassName = @"JHTimelineAPIResponse";
    }
    return self;
}

- (void)getTimelineDetails:(NSString *)token andLastCount:(int)lastCount{
    [self sendWebserviceRequest];
    NSString *url = [NSString stringWithFormat:BASE_URL,TIMELINE_URL];
    JHTimelineAPIRequest *request = [[JHTimelineAPIRequest alloc]init];
    request.token = token;
    request.dateTime = [Utility getFormattedDate];
    request.timeZone =  [[NSTimeZone localTimeZone]name];
    if (lastCount>0) {
        request.start = lastCount;
    }

    [baseWebService_ performPostRequest:url withRequestObject:request];
}


- (void)didReceiveData:(JHBaseResponse *)responseObj{
    if ([delegate_ respondsToSelector:@selector(didReceiveTimelineDetails:)]) {
        [delegate_ didReceiveTimelineDetails:(JHTimelineAPIResponse *)responseObj];
    }
    [super didReceiveData:responseObj];
}

@end
