//
//  JHLoginViewController.m
//  Encourage
//
//  Created by Abu on 12/07/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHLoginViewController.h"
#import "JHRegistrationViewController.h"
@implementation JHLoginViewController

@synthesize testString;


- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.loginField) {
        [self.passwordField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

-(IBAction)registerButtonPressed:(id)sender{
    JHRegistrationViewController *viewController = [[JHRegistrationViewController alloc]initWithNibName:@"JHRegistrationViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
