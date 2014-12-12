//
//  JHCareTaskListViewController.h
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseViewController.h"
#import "JHRecentCareTasksCell.h"
#import "JHCareTaskStatusAPI.h"

@interface JHCareTaskListViewController : JHBaseViewController<UITableViewDataSource,UITableViewDelegate,JHCareTaskActionDelegate,JHCareTaskStatusAPIDelegate>{
    JHCareTaskStatusAPI *careTaskStatusAPI;
}
- (IBAction)close:(id)sender;

@end
