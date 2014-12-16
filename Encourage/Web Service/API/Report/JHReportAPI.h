//
//  JHReportAPI.h
//  Encourage
//
//  Created by kiran vs on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseAPI.h"
#import "JHReportAPIRequest.h"
#import "JHReportAPIResponse.h"

@protocol JHReportAPIDelegate;
@interface JHReportAPI : JHBaseAPI

- (void)sendReport:(JHReportAPIRequest *)request;

@end

@protocol JHReportAPIDelegate <JHBaseAPIDelegate>

- (void)didReceiveReportResponse:(JHReportAPIResponse *)response;
- (void)failedToPostReport:(NSString *)message;
@end
