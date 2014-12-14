//
//  JHAlert.h
//  Encourage
//
//  Created by Abu on 11/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "KVCBaseObject.h"

@interface JHAlert : KVCBaseObject
@property NSString *notificationType;
@property NSString *alertKey;
@property NSString *dateTime;
@property NSString *contentType;
@property NSString *readStatus;
@property NSString *title;
@property NSString *details;
@property NSString *url;
@property NSString *urlHeader;
@property NSString *eventAddress;
@property NSString *image;
@property NSString *documentActualName;
@end
