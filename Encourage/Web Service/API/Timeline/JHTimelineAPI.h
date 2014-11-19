//
//  JHTimelineAPI.h
//  Encourage
//
//  Created by Abu on 12/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseAPI.h"
#import "JHTimelineAPIResponse.h"

@protocol JHTimelineAPIDelegate;
@interface JHTimelineAPI : JHBaseAPI

- (void)getTimelineDetails:(NSString *)token andLastCount:(int) lastCount withLoadingIndicator:(BOOL)loading;

@end

@protocol JHTimelineAPIDelegate <JHBaseAPIDelegate>

- (void)didReceiveTimelineDetails:(JHTimelineAPIResponse *)response;

@end