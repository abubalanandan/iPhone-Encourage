//
//  JHReportPageOne.m
//  Encourage
//
//  Created by kiran vs on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHReportPageOne.h"

@implementation JHReportPageOne

- (void)setTags {
    
    [button1 setTag:ReportButtonTypeSoreThroat];
    [button2 setTag:ReportButtonTypeTired];
    [button3 setTag:ReportButtonTypeBackPain];
    [button4 setTag:ReportButtonTypeDizziness];
    [button5 setTag:ReportButtonTypeCantSleep];
    [button6 setTag:ReportButtonTypeJointPain];
    [button7 setTag:ReportButtonTypeDrySkin];
    [button8 setTag:ReportButtonTypeNoseBleed];
    [button9 setTag:ReportButtonTypeShortnessOfBreath];
}

- (NSArray *)getPageOneStatus {
    
    NSMutableArray *tagArray = [NSMutableArray array];
    for (UIView *subView in [scrollView subviews]) {
        UIButton *btn = (UIButton *)subView;
        if (btn.isEnabled) {
            [tagArray addObject:[NSString stringWithFormat:@"%ld", (long)btn.tag]];
        }
    }
    return [NSArray arrayWithArray:tagArray];
}

- (IBAction)action:(id)sender {
    
}

@end
