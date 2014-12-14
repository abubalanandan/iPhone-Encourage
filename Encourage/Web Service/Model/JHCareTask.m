//
//  JHAlert.m
//  Encourage
//
//  Created by Abu on 11/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHCareTask.h"
#import "JHTimelineDetailItem.h"

@implementation JHCareTask
- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"objects"]) {
        
        return [NSString stringWithCString:class_getName([JHTimelineDetailItem class]) encoding:NSUTF8StringEncoding];;
    }
    return nil;
}

- (BOOL)isEqual:(id)other
{
    JHCareTask *otherItem = (JHCareTask *)other;
    if ([otherItem.careTaskId isEqualToString:self.careTaskId]) {
        return YES;
    }
    return NO;
}

-(NSComparisonResult)compare:(JHCareTask *)otherCareTask{
    NSDate *date = [Utility formattedDateFromString:self.careTaskDateTime];
    NSDate *secondDate = [Utility formattedDateFromString:otherCareTask.careTaskDateTime];
    return [secondDate compare:date];
}
@end
