//
//  JHReportPageThree.m
//  Encourage
//
//  Created by kiran vs on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHReportPageThree.h"

@implementation JHReportPageThree

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [containerScrollView setContentSize:containerView.frame.size];
    [dateTextField setText:[self formatDate:[NSDate date]]];
}

#pragma mark -
#pragma mark - IBActions

- (IBAction)selectImage:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

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
#pragma mark - UIImagePicker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    selectedImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
    
    [textField resignFirstResponder];
    APP_DELEGATE.shouldEnableScrolling = YES;
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

- (UIImage *)getImage {
    
    return selectedImageView.image;
}

- (NSDictionary *)getData {
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:dateTextField.text, @"date", commentsTextField.text, @"description", nil];
    return dict;
}

@end
