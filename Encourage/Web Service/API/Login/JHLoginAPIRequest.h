//
//  JHLoginAPIRequest.h
//  Encourage
//
//  Created by Abu on 22/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseRequest.h"

@interface JHLoginAPIRequest : JHBaseRequest
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *dateTime;
@property (nonatomic, strong) NSString *timeZone;
@property (nonatomic, strong) NSString *gcmRegistrationId;
@property (nonatomic, strong) NSString *deviceType;
@end
