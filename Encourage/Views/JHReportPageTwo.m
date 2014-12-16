//
//  JHReportPageTwo.m
//  Encourage
//
//  Created by kiran vs on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//


#import "JHReportPageTwo.h"

@implementation JHReportPageTwo

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [containerScrollView setContentSize:containerView.frame.size];
    [dateTextField setText:[self formatDate:[NSDate date]]];
    [self setTags];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearAllSelection) name:@"kClearAllButtonSelectionNotification" object:nil];
}


- (void)setTags {
    
    [button1 setTag:ReportButtonTypeWorried];
    [button2 setTag:ReportButtonTypeAnxious];
    [button3 setTag:ReportButtonTypeDepressed];
    [button4 setTag:ReportButtonTypeAngry];
    [button5 setTag:ReportButtonTypeSad];
    [button6 setTag:ReportButtonTypeHappy];
    [button7 setTag:ReportButtonTypeRestless];
    [button8 setTag:ReportButtonTypeCantSleep];
}

- (NSDictionary *)getPageTwoStatus {
    
    NSMutableDictionary *statusDict = [NSMutableDictionary dictionary];
    NSMutableArray *tagArray = [NSMutableArray array];
    for (UIView *subView in [containerView subviews]) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            if (btn.selected) {
                [tagArray addObject:[NSString stringWithFormat:@"%ld", (long)btn.tag]];
            }
        }
    }
    [statusDict setObject:[NSArray arrayWithArray:tagArray] forKey:@"events"];
    [statusDict setObject:dateTextField.text forKey:@"date"];
    [statusDict setObject:commentsTextField.text forKey:@"eventDescription"];
    
    return [NSDictionary dictionaryWithDictionary:statusDict];
}

- (IBAction)action:(UIButton *)sender {
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:[sender tag]];
    [btn setSelected:!btn.selected];
    
}

#pragma mark -
#pragma mark - IBAction

- (IBAction)doneAction:(id)sender {
    
    [dateTextField setText:[self formatDate:datePicker.date]];
    [self cancelAction:nil];
}

- (IBAction)cancelAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kEnableContainerScrollNotification" object:nil];
    APP_DELEGATE.shouldEnableScrolling = YES;
    [pickerContainerView setHidden:YES];
}

#pragma mark -
#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == dateTextField) {
        
        [self showDatePicker];
        return NO;
    }
    else {
        APP_DELEGATE.shouldEnableScrolling = NO;
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    APP_DELEGATE.shouldEnableScrolling = YES;
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kEnableContainerScrollNotification" object:nil];
    APP_DELEGATE.shouldEnableScrolling = YES;
}

#pragma mark -
#pragma mark - UIPicker Methods

- (void)showDatePicker {
    
    APP_DELEGATE.shouldEnableScrolling = NO;
    [pickerContainerView setHidden:NO];
    
}

#pragma mark -

- (NSString *)formatDate:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, yyyy"];
    NSString *formattedDate = [formatter stringFromDate:date];
    return formattedDate;
}


- (void)clearAllSelection {
    
    for (UIView *subView in [containerView subviews]) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            [btn setSelected:NO];
        }
    }
}

@end
