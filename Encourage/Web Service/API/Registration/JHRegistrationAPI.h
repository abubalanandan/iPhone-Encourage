//
//  JHRegistrationAPI.h
//  Encourage
//
//  Created by Abu on 14/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseAPI.h"

@interface JHRegistrationAPI : JHBaseAPI
- (void)registerUser:(NSString *)firstName :(NSString *)lastName :(NSString *)emailAddress;
@end

@protocol JHRegistrationAPIDelegate<JHBaseAPIDelegate>
- (void)didRegisterUserSuccessfully;
- (void)userRegistrationFailed:(NSString *)errorMessage;
@end