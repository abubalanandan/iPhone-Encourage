//
//  JHImageUploadAPI.h
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseAPI.h"
#import "JHImageUploadAPIResponse.h"
@protocol JHImageUploadDelegate;
@interface JHImageUploadAPI : JHBaseAPI


-(void)uploadImageWithPath:(NSString *)path;

@end

@protocol JHImageUploadDelegate <JHBaseAPIDelegate>

- (void)didUploadImage:(JHImageUploadAPIResponse *)responseObj;
- (void)imageUploadFailed:(NSString *)message;

@end