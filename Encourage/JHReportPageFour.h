//
//  JHReportPageFour.h
//  Encourage
//
//  Created by kiran vs on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHReportPageFour : JHBaseViewController <UITextFieldDelegate>{
    
    IBOutlet UITextField *dateTextField, *eventNameTextField, *eventAdressTextField, *eventDescriptionTextField;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *pickerContainerView, *containerView;
}

@end
