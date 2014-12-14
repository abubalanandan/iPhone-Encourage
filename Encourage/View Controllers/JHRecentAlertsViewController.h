//
//  JHRecentAlertsViewController.h
//  Encourage
//
//  Created by Abu on 12/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHRecentAlertsViewController : JHBaseViewController<UITableViewDataSource,UITableViewDelegate>
-(IBAction)closeButtonPressed:(id)sender;
-(IBAction)viewAllAlerts:(id)sender;
@end
