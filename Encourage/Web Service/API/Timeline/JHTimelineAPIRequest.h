//
//  JHTimelineAPIRequest.h
//  Encourage
//
//  Created by Abu on 12/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseRequest.h"

@interface JHTimelineAPIRequest : JHBaseRequest
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *dateTime;
@property (nonatomic,strong) NSString *timeZone;
@property int start;
@end
