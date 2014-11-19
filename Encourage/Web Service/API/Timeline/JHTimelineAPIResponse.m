//
//  JHTimelineAPIResponse.m
//  Encourage
//
//  Created by Abu on 12/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHTimelineAPIResponse.h"
#import "JHTimelineItem.h"
#import <objc/runtime.h>

@implementation JHTimelineAPIResponse

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"objects"]) {
        
        return [NSString stringWithCString:class_getName([JHTimelineItem class]) encoding:NSUTF8StringEncoding];;
    }
    return nil;
}

@end
