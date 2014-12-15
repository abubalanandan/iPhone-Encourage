//
//  JHAlertStatusAPI.h
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseAPI.h"
#import "JHAlertStatusAPIRequest.h"
#import "JHAlertStatusAPIResponse.h"
@protocol JHAlertStatusAPIDelegate;
@interface JHAlertStatusAPI : JHBaseAPI

-(void)markAlertAsRead:(NSString *)alertKey;
@end

@protocol JHAlertStatusAPIDelegate <JHBaseAPIDelegate>

-(void)markedAlertSuccessfully;
-(void)failedToMarkAlert:(NSString *)message;

@end