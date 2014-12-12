//
//  JHCareTaskDetailViewCell.m
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHCareTaskDetailViewCell.h"

@implementation JHCareTaskDetailViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(IBAction)done:(id)sender{
    if ([self.delegate respondsToSelector:@selector(markCareTask:AsDone:)]) {
        [self.delegate markCareTask:self.caretask AsDone:YES];
    }
}
-(IBAction)notDone:(id)sender{
    if ([self.delegate respondsToSelector:@selector(markCareTask:AsDone:)]) {
        [self.delegate markCareTask:self.caretask AsDone:NO];
    }
}

@end
