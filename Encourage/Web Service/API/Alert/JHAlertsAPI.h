//
//  JHAlertsAPI.h
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseAPI.h"
#import "JHAlertsAPIRequest.h"
#import "JHAlertsAPIResponse.h"
@protocol JHAlertsAPIDelegate;
@interface JHAlertsAPI : JHBaseAPI

- (void)getAlertDetails:(NSString *)token andLastCount:(int) lastCount ;

@end

@protocol JHAlertsAPIDelegate <JHBaseAPIDelegate>

- (void)didReceiveAlertsDetails:(JHAlertsAPIResponse *)response;

@end