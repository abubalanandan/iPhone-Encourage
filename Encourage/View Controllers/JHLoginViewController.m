//
//  JHLoginViewController.m
//  Encourage
//
//  Created by Abu on 12/07/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHLoginViewController.h"
#import "JHRegistrationViewController.h"
#import "JHWebService.h"
#import "JHLoginAPI.h"
#import "JHLoginAPIRequest.h"
#import "JHTimelineAPI.h"
#import "JHTimelineViewController.h"
#import "JHLeftPanelViewController.h"

@implementation JHLoginViewController

@synthesize testString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        loginAPI_ = [[JHLoginAPI alloc]init];
        loginAPI_.delegate = self;
    }
    return self;
}

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


-(IBAction)loginButtonPressed:(id)sender{
    JHLoginAPIRequest *loginRequest = [[JHLoginAPIRequest alloc]init];
    loginRequest.emailAddress = self.loginField.text;
    loginRequest.password = self.passwordField.text;
    loginRequest.emailAddress = @"abu.316@gmail.com";
    loginRequest.password = @"Sachin@10";
    loginRequest.gcmRegistrationId = ([JHAppDelegate application].dataManager.deviceToken)?[JHAppDelegate application].dataManager.deviceToken:@"afas";
    loginRequest.deviceType = @"iOS";
    loginRequest.timeZone = @"Asia/Kolkata";
    loginRequest.dateTime = @"20-10-2014 14:54:11";
    
    [loginAPI_ performLogin:loginRequest];
}


#pragma mark
#pragma mark -- Login API delegate methods

- (void)didReceiveLoginDetails:(JHLoginAPIResponse *)responseObj{
    [JHAppDelegate application].dataManager.token = responseObj.token;
    [JHAppDelegate application].dataManager.profilePicURL = responseObj.personProfilePic;
    [JHAppDelegate application].dataManager.username = responseObj.personName;
    [[JHAppDelegate application] setupLeftPanel];
    JHLeftPanelViewController *leftPanel =(JHLeftPanelViewController *) [JHAppDelegate application].sidePanel.leftPanel;
    [leftPanel setUpViewsWithName:responseObj.personName email:@"abu.316@gmail.com" andProfilePic:responseObj.personProfilePic];
       JHTimelineViewController *timelineVC = [[JHTimelineViewController alloc]init];
    [JHAppDelegate application].sidePanel.centerPanel = timelineVC;
    [JHAppDelegate application].window.rootViewController = [JHAppDelegate application].sidePanel;
    NSLog(@"TOKEN----%@",responseObj.token);
}


- (void)loginFailed:(NSString *)message{
    [Utility showOkAlertWithTitle:@"Failure" message:message];
}


-(IBAction)registerButtonPressed:(id)sender{
    JHRegistrationViewController *viewController = [[JHRegistrationViewController alloc]initWithNibName:@"JHRegistrationViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
   
}
@end
