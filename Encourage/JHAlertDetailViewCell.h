//
//  JHAlertDetailViewCell.h
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHAlert.h"

@interface JHAlertDetailViewCell : UITableViewCell
@property IBOutlet UILabel *urlHeader;
@property IBOutlet UIImageView *urlPreviewImage;
@property IBOutlet UILabel *urlPreviewLabel;
@property IBOutlet UILabel *alertTitleLabel;
@property IBOutlet UILabel *dateTimeLabel;
@property IBOutlet UIView *urlDetailView;
@property IBOutlet UIView *detailsView;
@property IBOutlet UIView *whiteView;
@property JHAlert *alert;
@end
