//
//  JHTimelineAPIResponse.h
//  Encourage
//
//  Created by Abu on 12/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseRequest.h"
#import "JHBaseResponse.h"

@interface JHTimelineAPIResponse : JHBaseResponse
@property   int lastCount;
@property (nonatomic,strong) NSArray *objects;
@end
