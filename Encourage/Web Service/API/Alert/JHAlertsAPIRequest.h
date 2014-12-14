//
//  JHAlertsAPIRequest.h
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseRequest.h"

@interface JHAlertsAPIRequest : JHBaseRequest
@property NSString *dateTime;
@property NSString *timeZone;
@property NSString *token;
@property int start;
@end
