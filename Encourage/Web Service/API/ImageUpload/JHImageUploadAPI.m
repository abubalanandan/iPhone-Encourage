//
//  JHImageUploadAPI.m
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHImageUploadAPI.h"

@implementation JHImageUploadAPI
- (id)init {
    self = [super init];
    if (self) {
        baseWebService_.responseClassName = @"JHImageUploadAPIResponse";
    }
    return self;
}

- (void)uploadImageWithPath:(NSString *)path{
    [self sendWebserviceRequest];
    [baseWebService_ postDataWithImagePath:path andImageType:@"image/png" andToken:[JHAppDelegate application].dataManager.token];
}

- (void)didReceiveData:(JHBaseResponse *)responseObj {
    
    JHImageUploadAPIResponse *response = (JHImageUploadAPIResponse *)responseObj;
    if ([delegate_ respondsToSelector:@selector(didUploadImage:)]) {
        [delegate_ didUploadImage:(JHImageUploadAPIResponse *)response];
    }
    [super didReceiveData:responseObj];
}


@end
