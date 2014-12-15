//
//  JHCareTaskStatusAPI.m
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHCareTaskStatusAPI.h"

@implementation JHCareTaskStatusAPI

- (id)init {
    self = [super init];
    if (self) {
        
        baseWebService_.responseClassName = @"JHCareTaskStatusAPIResponse";
    }
    return self;
}


- (void)updateCareTaskStatus:(JHCareTask *)caretask status:(NSString *)status{
    
    [self sendWebserviceRequest];
    
    JHCareTaskStatusAPIRequest *request = [[JHCareTaskStatusAPIRequest alloc]init];
    request.dateTime = [Utility getFormattedDate];
    request.timeZone = [NSTimeZone localTimeZone].name;
    request.token = [JHAppDelegate application].dataManager.token;
    request.careTaskId = caretask.careTaskId;
    request.status = status;
    
    NSString *url = [NSString stringWithFormat:BASE_URL,UPDATE_CARETASK_STATUS_URL];
    [baseWebService_ performPostRequest:url withRequestObject:request];
    
    
}

- (void)didReceiveData:(JHBaseResponse *)responseObj{
    if ([delegate_ respondsToSelector:@selector(didUpdateCaretaskStatus:)]){
        [delegate_ didUpdateCaretaskStatus:(JHCareTaskStatusAPIResponse *)responseObj];
    }
    [super didReceiveData:responseObj];
}

- (void)didReceiveNetworkError:(NSString *)errorMessage{
    [super didReceiveNetworkError:errorMessage];

    if ([delegate_ respondsToSelector:@selector(failedToUpdateCareTask)]) {
        [delegate_ failedToUpdateCareTask];
    }
}

@end
