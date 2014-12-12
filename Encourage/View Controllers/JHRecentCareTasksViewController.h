//
//  JHRecentCareTasksViewController.h
//  Encourage
//
//  Created by Abu on 12/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseViewController.h"
#import "JHRecentCareTasksCell.h"
#import "JHCareTaskStatusAPI.h"

@interface JHRecentCareTasksViewController : JHBaseViewController<UITableViewDataSource,UITableViewDelegate,JHCareTaskActionDelegate,JHCareTaskStatusAPIDelegate>{
    JHCareTaskStatusAPI *careTaskStatusAPI;
}
- (IBAction)close:(id)sender;
- (IBAction)viewAllCareTasks:(id)sender;
@end
