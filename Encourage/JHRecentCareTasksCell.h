//
//  JHRecentCareTasksCell.h
//  Encourage
//
//  Created by Abu on 12/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCareTask.h"

@protocol  JHCareTaskActionDelegate;

@interface JHRecentCareTasksCell : UITableViewCell
@property IBOutlet UILabel *careTaskTitleLabel;
@property IBOutlet UILabel *dueDateLabel;
@property IBOutlet UIImageView *medImageView;
@property IBOutlet UIView *whiteView;
@property JHCareTask *caretask;
@property (weak,nonatomic) id<JHCareTaskActionDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)notDone:(id)sender;
@end

@protocol JHCareTaskActionDelegate <NSObject>

- (void)markCareTask:(JHCareTask *)caretask AsDone:(BOOL)done;

@end
