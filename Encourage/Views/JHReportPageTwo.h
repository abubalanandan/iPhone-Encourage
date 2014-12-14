//
//  JHReportPageTwo.h
//  Encourage
//
//  Created by kiran vs on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHReportPageTwo : UIViewController <UITextFieldDelegate>{
    
    IBOutlet UITextField *dateTextField, *commentsTextField;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *pickerContainerView;
    IBOutlet UIScrollView *containerScrollView;
    IBOutlet UIView *containerView;
    IBOutlet UIButton *button1, *button2, *button3, *button4, *button5, *button6, *button7, *button8;
}

- (NSArray *)getPageTwoStatus;

@end
