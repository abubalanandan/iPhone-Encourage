//
//  JHAlert.m
//  Encourage
//
//  Created by Abu on 11/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHAlert.h"

@implementation JHAlert

-(BOOL)isEqual:(id)object{
    JHAlert *otherObject = (JHAlert *)object;
    if ([otherObject.alertKey isEqualToString:self.alertKey]) {
        return YES;
    }
    return NO;
}

-(NSComparisonResult)compare:(JHAlert *)otherAlert{
    NSDate *date = [Utility formattedDateFromString:self.dateTime];
    NSDate *secondDate = [Utility formattedDateFromString:otherAlert.dateTime];
    return [secondDate compare:date];
}

@end
