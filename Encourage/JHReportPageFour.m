//
//  JHReportPageFour.m
//  Encourage
//
//  Created by kiran vs on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHReportPageFour.h"

@implementation JHReportPageFour

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [dateTextField setText:[self formatDate:[NSDate date]]];
}



#pragma mark -
#pragma mark - IBAction

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

    if (textField == dateTextField) {
        [eventNameTextField becomeFirstResponder];
    }else if(textField == eventNameTextField){
        [eventAdressTextField becomeFirstResponder];
    }else if(textField == eventAdressTextField){
        [eventDescriptionTextField becomeFirstResponder];
    }
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

- (BOOL)validateFields {
    
    if (eventAdressTextField.text.length == 0 || eventDescriptionTextField.text.length == 0 || eventNameTextField.text.length == 0) {
        return NO;
    }
    return YES;
}

- (NSDictionary *)getPageFourData {
    
    if (![self validateFields]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter event name, address and description" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return nil;
    }
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:eventNameTextField.text, @"eventName", eventDescriptionTextField.text, @"eventDesc", eventAdressTextField.text, @"eventAddress", dateTextField.text, @"date", nil];
    return dict;
}


@end
