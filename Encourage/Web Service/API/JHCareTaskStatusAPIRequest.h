//
//  JHCareTaskStatusAPIRequest.h
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseRequest.h"

@interface JHCareTaskStatusAPIRequest : JHBaseRequest
@property NSString *dateTime;
@property NSString *timeZone;
@property NSString *careTaskId;
@property NSString *status;
@property NSString *token;
@end
