//
//  JHTimelineItem.m
//  Encourage
//
//  Created by Abu on 12/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHTimelineItem.h"
#import "JHTimelineDetailItem.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@implementation JHTimelineItem

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"details"]) {
        
        return [NSString stringWithCString:class_getName([JHTimelineDetailItem class]) encoding:NSUTF8StringEncoding];;
    }
    return nil;
}


@end
