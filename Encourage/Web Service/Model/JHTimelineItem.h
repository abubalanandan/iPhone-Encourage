//
//  JHTimelineItem.h
//  Encourage
//
//  Created by Abu on 12/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVCBaseObject.h"

@interface JHTimelineItem : KVCBaseObject
@property (nonatomic,strong) NSString *timelineId;
@property (nonatomic,strong) NSString *dateTime;
@property (nonatomic,strong) NSString *dataType;
@property (nonatomic,strong) NSString *person;
@property (nonatomic,strong) NSString *personProfilePictureName;
@property (nonatomic,strong) NSString *documentActualName;
@property (nonatomic,strong) NSString *personRole;
@property (nonatomic,strong) NSArray *details;
@property (nonatomic,strong) NSString *header;

@end
