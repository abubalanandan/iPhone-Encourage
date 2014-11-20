//
//  JHLogoutAPI.h
//  Encourage
//
//  Created by Abu on 20/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseAPI.h"

@interface JHLogoutAPI : JHBaseAPI

- (void)logout;
@end

@protocol JHLogoutAPIDelegate <JHBaseAPIDelegate>

- (void)loggedOutSuccessfully;
- (void)logoutFailed:(NSString *)message;
@end