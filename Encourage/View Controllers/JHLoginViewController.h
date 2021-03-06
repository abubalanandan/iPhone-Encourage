//
//  JHLoginViewController.h
//  Encourage
//
//  Created by Abu on 12/07/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHLoginAPI.h"
#import "JHBaseViewController.h"
#import "JHTimelineAPI.h"

@interface JHLoginViewController : JHBaseViewController<UITextFieldDelegate,JHLoginAPIDelegate, UIAlertViewDelegate>{
    JHLoginAPI *loginAPI_;
    
}

@property (nonatomic, strong) NSString *testString;
@property IBOutlet UITextField *loginField;
@property IBOutlet UITextField *passwordField;
-(IBAction)registerButtonPressed:(id)sender;
-(IBAction)loginButtonPressed:(id)sender;

@end
