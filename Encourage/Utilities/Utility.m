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

+ (CGFloat)requiredHeightWithKey:(NSString *)key andValue:(NSString *)value forCellWidth:(CGFloat)cellWidth{
    CGSize constrainedSize = CGSizeMake(cellWidth  , 9999);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:12.0], NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:key attributes:attributesDictionary];
    
    CGFloat requiredKeyHeight = CGRectGetHeight([string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil]);
    
    NSMutableAttributedString *valueString = [[NSMutableAttributedString alloc]initWithString:value attributes:attributesDictionary];
    CGFloat requiredValueHeight =CGRectGetHeight( [valueString boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil]);
    
    return (requiredKeyHeight>requiredValueHeight)?requiredKeyHeight:requiredValueHeight;
}

+ (CGFloat)requiredHeightWithString:(NSString *)valueString forCellWidth:(CGFloat)cellWidth{
    CGSize constrainedSize = CGSizeMake(cellWidth  , 9999);

    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:12.0], NSFontAttributeName,
                                          nil];
      NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:valueString attributes:attributesDictionary];
      CGFloat requiredHeight = CGRectGetHeight([string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil]);
    return requiredHeight;
}

+ (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}


+ (void)showOkAlertWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

+ (NSDate *)formattedDateFromString:(NSString *)dateString{
    NSString *formattedString = [dateString stringByReplacingOccurrencesOfString:@"@" withString:@" "];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"MMMM dd yyyy hh:mma"];
    return [dateFormatter dateFromString:formattedString];
}

@end
