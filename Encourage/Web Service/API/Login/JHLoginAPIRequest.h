//
//  JHLoginAPIRequest.h
//  Encourage
//
//  Created by Abu on 22/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseRequest.h"

@interface JHLoginAPIRequest : JHBaseRequest
@property (nonatomic, strong) NSString *email_address;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *dateTime;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, strong) NSString *gcmRegistrationId;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *operationName;
@end
