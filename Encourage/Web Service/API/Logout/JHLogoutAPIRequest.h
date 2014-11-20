//
//  JHLogoutAPIRequest.h
//  Encourage
//
//  Created by Abu on 20/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseRequest.h"

@interface JHLogoutAPIRequest : JHBaseRequest
@property (nonatomic,strong) NSString *token;
@end
