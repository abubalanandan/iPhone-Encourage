//
//  JHCareTaskStatusAPI.h
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseAPI.h"
#import "JHCareTaskStatusAPIResponse.h"
#import "JHCareTaskStatusAPIRequest.h"
#import "JHCareTask.h"

@interface JHCareTaskStatusAPI : JHBaseAPI

- (void)updateCareTaskStatus:(JHCareTask *)caretask status:(NSString *)status;
@end

@protocol JHCareTaskStatusAPIDelegate <JHBaseAPIDelegate>
-(void) didUpdateCaretaskStatus:(JHCareTaskStatusAPIResponse *) responseObj;
-(void) failedToUpdateCareTask;
@end