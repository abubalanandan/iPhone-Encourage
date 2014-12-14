//
//  JHAlertsAPIResponse.m
//  Encourage
//
//  Created by Abu on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHAlertsAPIResponse.h"
#import "JHAlert.h"

@implementation JHAlertsAPIResponse
- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"objects"]) {
        
        return [NSString stringWithCString:class_getName([JHAlert  class]) encoding:NSUTF8StringEncoding];;
    }
    return nil;
}

@end
