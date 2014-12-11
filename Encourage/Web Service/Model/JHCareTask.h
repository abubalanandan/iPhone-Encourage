//
//  JHAlert.h
//  Encourage
//
//  Created by Abu on 11/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "KVCBaseObject.h"

@interface JHCareTask : KVCBaseObject
@property NSString *notificationType;
@property NSString *careTaskId;
@property NSString *careTaskType;
@property NSString *careTaskDateTime;
@property NSString *providerName;
@property NSString *title;
@property NSArray *objects;
@end
