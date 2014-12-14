//
//  JHAlertsListViewController.h
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseViewController.h"

@interface JHAlertsListViewController : JHBaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
}

@property IBOutlet UITableView *alertsTV;
@property NSMutableArray *alerts;
- (IBAction)close:(id)sender;

@end
