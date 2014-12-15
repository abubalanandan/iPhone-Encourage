//
//  JHRegistrationAPIRequest.h
//  Encourage
//
//  Created by Abu on 14/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseRequest.h"

@interface JHRegistrationAPIRequest : JHBaseRequest
@property (nonatomic,strong) NSString *fName;
@property (nonatomic,strong) NSString *lName;
@property (nonatomic,strong) NSString *emailAddress;
@property (nonatomic,strong) NSString *dateTime;
@property (nonatomic,strong) NSString *timeZone;
@end
