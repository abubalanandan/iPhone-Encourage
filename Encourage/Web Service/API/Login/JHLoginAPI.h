//
//  JHLoginAPI.h
//  Encourage
//
//  Created by Abu on 22/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseAPI.h"
#import "JHLoginAPIResponse.h"
#import "JHLoginAPIRequest.h"

@protocol JHLoginAPIDelegate;
@interface JHLoginAPI : JHBaseAPI

-(void) performLogin:(JHLoginAPIRequest *)request;

@end

@protocol JHLoginAPIDelegate <JHBaseAPIDelegate>
-(void) didReceiveLoginDetails:(JHLoginAPIResponse *) responseObj;

@end
