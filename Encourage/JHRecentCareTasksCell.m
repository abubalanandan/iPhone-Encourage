//
//  JHRecentCareTasksCell.m
//  Encourage
//
//  Created by Abu on 12/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHRecentCareTasksCell.h"
#import "JHHudController.h"

@implementation JHRecentCareTasksCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(IBAction)done:(id)sender{
    [JHHudController displayHUDWithTitle:@"" withMessage:@"DONE" time:2];
}

-(IBAction)notDone:(id)sender{
    [JHHudController displayHUDWithTitle:@"" withMessage:@"NOT DONE!!!" time:2];

}

@end
