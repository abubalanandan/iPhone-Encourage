//
//  JHCareTaskDetailViewCell.h
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCareTask.h"
#import "JHRecentCareTasksCell.h"

@interface JHCareTaskDetailViewCell : UITableViewCell
@property IBOutlet UIView *detailsView;
@property IBOutlet UIView *whiteView;
@property IBOutlet UILabel *careTaskTitleLabel;
@property IBOutlet UILabel *dueDateLabel;
@property IBOutlet UIImageView *medImageView;
@property IBOutlet UIButton *doneButton;
@property IBOutlet UIButton *notDoneButton;
@property JHCareTask *caretask;
@property id<JHCareTaskActionDelegate>delegate;


-(IBAction)done:(id)sender;
-(IBAction)notDone:(id)sender;
@end
