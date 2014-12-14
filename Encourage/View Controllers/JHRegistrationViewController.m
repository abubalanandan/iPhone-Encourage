//
//  JHRegistrationViewController.m
//  Encourage
//
//  Created by Abu on 12/07/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHLoginViewController.h"
#import "JHRegistrationViewController.h"
#import "KGModal.h"
@interface JHRegistrationViewController ()

@end

@implementation JHRegistrationViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"jhlpolicy" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSString *termsString = @"By clicking Register, you agree to our Terms and Conditions documented herein";
    NSRange range = [termsString rangeOfString:@"Terms and Conditions"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:termsString];
    [attributedString addAttribute:NSLinkAttributeName value:url range:range];
    [_termsAndConditionsLabel setAttributedText:attributedString];
    _termsAndConditionsLabel.font = [UIFont systemFontOfSize:10.0];
    _termsAndConditionsLabel.textContainer.lineFragmentPadding = 0;
    _termsAndConditionsLabel.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _termsAndConditionsLabel.delegate = self;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.firstNameField) {
        [self.lastNameField becomeFirstResponder];
    }else if(textField == self.lastNameField){
        [textField resignFirstResponder];
        [self.emailAddressField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}




-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(20, 50, width-40, height-100)];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webview loadRequest:request];
    [KGModal sharedInstance].closeButtonType = KGModalCloseButtonTypeRight;
    [[KGModal sharedInstance]showWithContentView:webview andAnimated:YES];
    
    
    return YES;
}

-(IBAction)loginButtonPressed:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
