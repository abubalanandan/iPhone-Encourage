//
//  Utility.m
//  Encourage
//
//  Created by Abu on 22/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "Utility.h"
#import "Reachability.h"

@implementation Utility

+ (BOOL)isNetworkAvailable {
    
    Reachability *internetReach;
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if(netStatus == NotReachable) {
        return NO;
    }
    else
        return YES;
}

+ (NSString *)getFormattedDate{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
    return [formatter stringFromDate:date];
    
}
@end
