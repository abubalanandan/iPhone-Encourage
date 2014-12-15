//
//  JHImageUploadAPIResponse.h
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseResponse.h"

@interface JHImageUploadAPIResponse : JHBaseResponse
@property NSString *fileActualName;
@property NSString *fileName;
@property NSString *fileType;
@property NSString *token;
@end
