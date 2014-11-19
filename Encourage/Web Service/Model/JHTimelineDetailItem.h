//
//  JHTimelineDetailItem.h
//  Encourage
//
//  Created by Abu on 12/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVCBaseObject.h"

@interface JHTimelineDetailItem : KVCBaseObject
@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *value;
@end
