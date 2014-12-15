//
//  JHReportPageOne.m
//  Encourage
//
//  Created by kiran vs on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHReportPageOne.h"

@implementation JHReportPageOne

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [scrollView setContentSize:containerView.frame.size];
    [dateTextField setText:[self formatDate:[NSDate date]]];
    [self setTags];
}

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

- (NSDictionary *)getPageOneStatus {
    
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
    [statusDict setObject:descriptionTextField.text forKey:@"eventDescription"];
    
    return [NSDictionary dictionaryWithDictionary:statusDict];
}

#pragma mark -
#pragma mark - IBActions

- (IBAction)action:(UIButton *)sender {
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:[sender tag]];
    [btn setSelected:!btn.selected];
    
}

- (IBAction)doneAction:(id)sender {
    
    [dateTextField setText:[self formatDate:datePicker.date]];
    [self cancelAction:nil];
}

- (IBAction)cancelAction:(id)sender {
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
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark - UIPicker Methods

- (void)showDatePicker {
    
    [pickerContainerView setHidden:NO];
    
}

#pragma mark -

- (NSString *)formatDate:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, yyyy"];
    NSString *formattedDate = [formatter stringFromDate:date];
    return formattedDate;
}

@end
