//
//  JHBaseViewController.h
//  Encourage
//
//  Created by Abu on 23/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBaseViewController : UIViewController<UITextFieldDelegate>

@property CGRect keyboardFrame;
@property (strong, nonatomic) UITextField *activeField;
@end
