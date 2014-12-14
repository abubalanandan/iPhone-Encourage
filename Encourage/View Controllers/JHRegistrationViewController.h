//
//  JHRegistrationViewController.h
//  Encourage
//
//  Created by Abu on 12/07/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHBaseViewController.h"

@interface JHRegistrationViewController : JHBaseViewController<UITextViewDelegate>{
}
@property IBOutlet UITextView *termsAndConditionsLabel;
-(IBAction)loginButtonPressed:(id)sender;
@end
