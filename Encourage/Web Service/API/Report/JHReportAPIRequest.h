//
//  JHReportAPIRequest.h
//  Encourage
//
//  Created by kiran vs on 14/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHBaseRequest.h"

@interface JHReportAPIRequest : JHBaseRequest

@property (nonatomic, strong) NSString *dateTime;
@property (nonatomic, strong) NSString *timeZone;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSArray *eventData;
@property (nonatomic, strong) NSString *eventAddress;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *complaint;
@property (nonatomic, assign) BOOL informCC;
@property (nonatomic, strong) NSArray *nimycMails;
@property (nonatomic, strong) NSArray *nimycPersons;
@property (nonatomic, assign) BOOL addToMyCcs;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *fileActualName;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *fileType;
@property (nonatomic, strong) NSString *reportType;

@end
