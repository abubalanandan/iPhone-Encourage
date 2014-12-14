//
//  JHLoginAPIResponse.h
//  Encourage
//
//  Created by Abu on 22/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseResponse.h"

@interface JHLoginAPIResponse : JHBaseResponse
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *personName;
@property (nonatomic, strong) NSString *personProfilePic;
@end
