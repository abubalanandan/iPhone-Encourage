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
    loginRequest.email_address = self.loginField.text;
    loginRequest.password = self.passwordField.text;
    loginRequest.gcmRegistrationId = @"APA91bFqkDu1I4eYpkvjPN5RLf7QFibj9ncKsoYOjDKlsF_TZozpodNF16wUcSBhuHOnAidOMnADYJY8cqteSz-inA1TR2aM4OOnwkrO7ahHUuRO72VAVvjjjRTYo";
    loginRequest.operationName = @"userLogin";
    loginRequest.deviceType = @"iOS";
    loginRequest.timezone = @"Asia/Kolkata";
    loginRequest.dateTime = @"20-10-2014 14:54";
    
    [loginAPI_ performLogin:loginRequest];
}

//-(void)fireConnectionRequest {
//    
//    NSOperationQueue *mainQueue = [[NSOperationQueue alloc] init];
//    [mainQueue setMaxConcurrentOperationCount:5];
//    
//    NSError *error = Nil;
//    
//    NSURL *url = [NSURL URLWithString:@"https://tryencourage.com/hwdsi/hwservice/userLogin.php"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    
//    
//    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"abu.316@gmail.com",@"email_address",@"Sachin@10",@"password",@"",@"dateTime",@"Asia/Kolkata",@"timezone",@"userLogin",@"operationName", nil];
//    
//    NSData *sendData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//    
//    NSString *postLength = [NSString stringWithFormat:@"%d",[sendData length]];
//
//    [request setHTTPMethod:@"POST"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    [request setHTTPBody: sendData];
//    [NSURLConnection connectionWithRequest:request delegate:self];
//    
//    NSString *jsonString = [[NSString alloc]initWithData:sendData encoding:NSUTF8StringEncoding];
//    
//    
//    //fire URL connectiion request
//    [NSURLConnection sendAsynchronousRequest:request queue:mainQueue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
//        
//        //get the return message and transform to dictionary
//        NSString *data = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//        NSError *parseError = nil;
//        NSDictionary * xmlDict = [XMLReader dictionaryForXMLString:data error:&error];
//    
//        
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:xmlDict
//                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
//                                                             error:&error];
//        NSString *stringResponse = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        //check return message
//        if (!error) {
//            
//        }
//        else {
//        }
//        
//    }];
//    
//}

#pragma mark
#pragma mark -- Login API delegate methods

- (void)didReceiveLoginDetails:(JHLoginAPIResponse *)responseObj{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Success" message:responseObj.token delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertview show];
}

- (void)didFailDataFetch:(NSString *)error{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Failure" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertview show];
}

- (void)didFailNetwork:(NSString *)error{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Failure" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertview show];

}

- (void)didFailJsonException{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"JSON exception" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertview show];
}

- (void)didFailAuthentication:(NSString *)error{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Failure" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertview show];
}

- (void)didRequestTimedOut:(NSString *)error{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Failure" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertview show];

}

-(IBAction)registerButtonPressed:(id)sender{
//    JHRegistrationViewController *viewController = [[JHRegistrationViewController alloc]initWithNibName:@"JHRegistrationViewController" bundle:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
    //[self fireConnectionRequest];
//    JHWebService *service = [[JHWebService alloc]init];
//    service.responseClassName= @"IDAcceptJobResponse";
//    [service performPostRequest:@""];
}
@end
