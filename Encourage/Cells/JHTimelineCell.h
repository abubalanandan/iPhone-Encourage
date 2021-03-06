//
//  JHTimelineCell.h
//  Encourage
//
//  Created by Abu on 16/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHTimelineCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIView *detailsView;
@property (nonatomic,weak) IBOutlet UIImageView *dummyView;
@property (nonatomic,weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic,weak) IBOutlet UIView *backgroundGrayView;
@property (nonatomic,weak) IBOutlet UIView *headerView;
@property (nonatomic,weak) IBOutlet UILabel *personName;
@property (nonatomic,weak) IBOutlet UIImageView *profilePicImage;
@property (nonatomic,weak) IBOutlet UILabel *headerLabel;
@property (nonatomic,weak) IBOutlet UILabel *dateLabel;
@end
