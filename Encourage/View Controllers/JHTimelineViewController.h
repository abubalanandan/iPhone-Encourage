//
//  JHTimelineViewController.h
//  Encourage
//
//  Created by Abu on 02/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHBaseViewController.h"
#import "JHTimelineAPI.h"
@interface JHTimelineViewController : JHBaseViewController<JHTimelineAPIDelegate,UITableViewDataSource,UITableViewDelegate>{
    JHTimelineAPI *timelineAPI_;

}

@property (nonatomic,weak) IBOutlet UITableView *timelineTV;
@end
