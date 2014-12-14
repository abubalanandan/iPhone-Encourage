//
//  JHAlertsListViewController.h
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseViewController.h"
#import "JHAlertsAPI.h"
#import "JHAlert.h"

@interface JHAlertsListViewController : JHBaseViewController<UITableViewDelegate,UITableViewDataSource,JHAlertsAPIDelegate>{
    JHAlertsAPI *alertsAPI;
}

@property IBOutlet UITableView *alertsTV;
@property IBOutlet UIActivityIndicatorView *activity;
@property NSMutableArray *alerts;
@property JHAlert *selectedAlert;
- (IBAction)close:(id)sender;

@end
