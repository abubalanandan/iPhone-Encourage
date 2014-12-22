//
//  JHReportPageOne.h
//  Encourage
//
//  Created by kiran vs on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHReportPageOne : JHBaseViewController <UITextFieldDelegate> {
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *button1, *button2, *button3, *button4, *button5, *button6, *button7, *button8, *button9, *button10, *button11, *button12;
    IBOutlet UIView *containerView, *pickerContainerView;
    IBOutlet UITextField *dateTextField, *descriptionTextField;
    IBOutlet UIDatePicker *datePicker;
}

- (NSDictionary *)getPageOneStatus;

@end
