//
//  JHAlertsAPIResponse.h
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseResponse.h"

@interface JHAlertsAPIResponse : JHBaseResponse
@property   int lastCount;
@property (nonatomic,strong) NSArray *objects;
@end
