//
//  JHRecentCareTasksCell.h
//  Encourage
//
//  Created by Abu on 12/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHRecentCareTasksCell : UITableViewCell
@property IBOutlet UILabel *careTaskTitleLabel;
@property IBOutlet UILabel *dueDateLabel;
@property IBOutlet UIImageView *medImageView;
@property IBOutlet UIView *whiteView;

- (IBAction)done:(id)sender;
- (IBAction)notDone:(id)sender;
@end
