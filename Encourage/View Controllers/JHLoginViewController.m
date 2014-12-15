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
        [textField resignFirstResponder];
        [self.passwordField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}


-(IBAction)loginButtonPressed:(id)sender{
    if(TARGET_IPHONE_SIMULATOR){
        self.loginField.text = @"abu.316@gmail.com";
        self.passwordField.text = @"Sachin@10";
    }
    if (![self isEntriesValid]) {
        return;
    }
    
    JHLoginAPIRequest *loginRequest = [[JHLoginAPIRequest alloc]init];
    loginRequest.emailAddress = @"abu.316@gmail.com";//self.loginField.text;
    loginRequest.password = @"Sachin@10";//self.passwordField.text;
    
    loginRequest.gcmRegistrationId = ([JHAppDelegate application].dataManager.deviceToken)?[JHAppDelegate application].dataManager.deviceToken:@"afas";
    loginRequest.deviceType = @"iOS";
    loginRequest.timeZone = [[NSTimeZone localTimeZone]name];
   
    loginRequest.dateTime = [Utility getFormattedDate];
    
    [loginAPI_ performLogin:loginRequest];
}

- (BOOL)isEntriesValid{
    NSString *error = nil;
//    if (self.loginField.text == nil || self.loginField.text.length<5) {
//        error = @"Please enter a valid email address";
//    }else if(self.passwordField.text==nil || self.passwordField.text.length==0){
//        error = @"Please enter your password";
//    }
    if (error) {
        [Utility showOkAlertWithTitle:@"Warning" message:error];
        return NO;
    }
    return YES;
}
#pragma mark
#pragma mark -- Login API delegate methods

- (void)didReceiveLoginDetails:(JHLoginAPIResponse *)responseObj{
    [JHAppDelegate application].dataManager.token = responseObj.token;
    [JHAppDelegate application].dataManager.profilePicURL = responseObj.personProfilePic;
    [JHAppDelegate application].dataManager.username = responseObj.personName;
    [[JHAppDelegate application] setupLeftPanel];
    JHLeftPanelViewController *leftPanel =(JHLeftPanelViewController *) [JHAppDelegate application].sidePanel.leftPanel;
    [leftPanel setUpViewsWithName:responseObj.personName email:self.loginField.text andProfilePic:responseObj.personProfilePic];
       JHTimelineViewController *timelineVC = [[JHTimelineViewController alloc]init];
    [JHAppDelegate application].sidePanel.centerPanel = timelineVC;
    [JHAppDelegate application].window.rootViewController = [JHAppDelegate application].sidePanel;
}


- (void)loginFailed:(NSString *)message{
    [Utility showOkAlertWithTitle:@"Failure" message:message];
}


-(IBAction)registerButtonPressed:(id)sender{
    JHRegistrationViewController *viewController = [[JHRegistrationViewController alloc]initWithNibName:@"JHRegistrationViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
   
}
@end
