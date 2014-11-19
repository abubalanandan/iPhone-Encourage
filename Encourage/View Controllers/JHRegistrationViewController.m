//
//  JHRegistrationViewController.m
//  Encourage
//
//  Created by Abu on 12/07/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHLoginViewController.h"
#import "JHRegistrationViewController.h"
@interface JHRegistrationViewController ()

@end

@implementation JHRegistrationViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        timelineAPI = [[JHTimelineAPI alloc]init];
        timelineAPI.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [timelineAPI getTimelineDetails:[JHAppDelegate application].dataManager.token andLastCount:0];
    // Do any additional setup after loading the view from its nib.

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Test" message:@"message" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];

}

- (void)didReceiveTimelineDetails:(JHTimelineAPIResponse *)response{
    
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
