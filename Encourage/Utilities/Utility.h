//
//  Utility.h
//  Encourage
//
//  Created by Abu on 22/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (BOOL)isNetworkAvailable ;
+ (NSString *)getFormattedDate;
+ (CGFloat)requiredHeightWithKey:(NSString *)key andValue:(NSString *)value forCellWidth:(CGFloat)cellWidth;
+ (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell;
+ (CGFloat)requiredHeightWithString:(NSString *)valueString forCellWidth:(CGFloat)cellWidth;
@end
