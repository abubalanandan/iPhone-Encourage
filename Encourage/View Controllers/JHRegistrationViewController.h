//
//  JHRegistrationViewController.h
//  Encourage
//
//  Created by Abu on 12/07/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHBaseViewController.h"
#import "JHRegistrationAPI.h"

@interface JHRegistrationViewController : JHBaseViewController<UITextViewDelegate,UITextFieldDelegate,JHRegistrationAPIDelegate>{
    JHRegistrationAPI *regAPI;
}
@property IBOutlet UITextView *termsAndConditionsLabel;
@property IBOutlet UITextField *firstNameField;
@property IBOutlet UITextField *lastNameField;
@property IBOutlet UITextField *emailAddressField;
-(IBAction)loginButtonPressed:(id)sender;
-(IBAction)registerPressed:(id)sender;
@end
