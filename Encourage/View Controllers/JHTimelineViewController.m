//
//  JHTimelineViewController.m
//  Encourage
//
//  Created by Abu on 02/10/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHTimelineViewController.h"
#import "JHDataManager.h"
#import "JHTimelineCell.h"
#import "JHTimelineItem.h"
#import "JHTimelineDetailItem.h"
#import "UIImageView+WebCache.h"
#import "JHHudController.h"
#import "JHRecentCareTasksViewController.h"
#import "JHRecentAlertsViewController.h"
#import "JHReportViewController.h"

@interface JHTimelineViewController ()
@property int lastCount;
@property (nonatomic,strong) NSMutableArray *timelineItems;
@property BOOL loading;
@end

@implementation JHTimelineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        timelineAPI_ = [[JHTimelineAPI alloc]init];
        timelineAPI_.delegate = self;
        _lastCount = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [JHAppDelegate application].timelineVC = self;
    [[JHAppDelegate application].sidePanel leftButtonForCenterPanel:_menuButton];
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.timelineTV.bounds];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(backgroundView.frame), CGRectGetHeight(backgroundView.frame))];
    iv.image = [UIImage imageNamed:@"page_bg"];
    [backgroundView addSubview:iv];
    [self.timelineTV setBackgroundView:backgroundView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _loading = YES;

    [timelineAPI_ getTimelineDetails:[JHAppDelegate application].dataManager.token andLastCount:0 withLoadingIndicator:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark Timeline API delegate

- (void)didReceiveTimelineDetails:(JHTimelineAPIResponse *)response{
    _lastCount = response.lastCount;
    _loading = NO;
    _timelineTV.tableFooterView = nil;
    if (_timelineItems ==nil) {
        _timelineItems = [[NSMutableArray alloc]initWithArray:response.objects];
    }else{
        for (JHTimelineItem *timelineItem in response.objects) {
            if (![_timelineItems containsObject:timelineItem]) {
                [_timelineItems addObject:timelineItem];
            }
        }
    }
    [_timelineTV reloadData];
}

#pragma mark TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _timelineItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"JHTimelineCell";
    JHTimelineCell *timelineCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (timelineCell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JHTimelineCell" owner:self options:nil];
        timelineCell = [nibs objectAtIndex:0];
    }
    
    JHTimelineItem *item = (JHTimelineItem *)[_timelineItems objectAtIndex:indexPath.row];
    [self configureCell:timelineCell withItem:item];
    return timelineCell;
}


- (void)configureCell:(JHTimelineCell *)cell withItem:(JHTimelineItem *)item{
    NSArray *details = item.details;
    CGFloat labelWidth = cell.detailsView.bounds.size.width/2 - 10;
    CGFloat headerHeight = CGRectGetMaxY(cell.headerView.frame);
    cell.personName.text = item.person;
    cell.dateLabel.text = item.dateTime;
    cell.headerLabel.text = item.header;
    [cell.profilePicImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:FILE_URL,[JHAppDelegate application].dataManager.token,item.personProfilePictureName]] placeholderImage:[UIImage imageNamed:@"page_bg"]];
    [[cell.detailsView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGFloat detailViewHeight= 20;
    for (JHTimelineDetailItem *detail in details) {
        CGFloat labelHeight = [Utility requiredHeightWithKey:detail.key andValue:detail.value forCellWidth:labelWidth];
        UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, detailViewHeight, labelWidth, labelHeight)];
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelWidth+20, detailViewHeight, labelWidth, labelHeight)];
        [keyLabel setFont:[UIFont systemFontOfSize:12.0]];
        keyLabel.text = detail.key;
        valueLabel.text = detail.value;
        [valueLabel setFont:[UIFont systemFontOfSize:12.0]];
        keyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        valueLabel.lineBreakMode = NSLineBreakByWordWrapping;
        keyLabel.numberOfLines=0;
        valueLabel.numberOfLines=0;
        [cell.detailsView addSubview:keyLabel];
        [cell.detailsView addSubview:valueLabel];
        detailViewHeight +=labelHeight+5;
    }
    cell.detailsView.frame = CGRectMake(cell.detailsView.frame.origin.x, headerHeight+ 20, CGRectGetWidth(cell.detailsView.frame), detailViewHeight);
    CGFloat imageOffset = 0;
    if ([item.dataType containsString:@"Image"]) {
        cell.dummyView.hidden = NO;
        cell.dummyView.frame = CGRectMake(CGRectGetMinX(cell.dummyView.frame), CGRectGetMaxY(cell.detailsView.frame)+5, CGRectGetWidth(cell.dummyView.frame), CGRectGetHeight(cell.dummyView.frame));
        imageOffset = cell.dummyView.frame.size.height;
        [cell.dummyView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:FILE_URL,[JHAppDelegate application].dataManager.token,item.documentActualName]] placeholderImage:[UIImage imageNamed:@"page_bg"]] ;
    }else if([item.dataType containsString:@"Map"]){
        cell.dummyView.hidden = NO;
        cell.dummyView.frame = CGRectMake(CGRectGetMinX(cell.dummyView.frame), CGRectGetMaxY(cell.detailsView.frame)+5, CGRectGetWidth(cell.dummyView.frame), CGRectGetHeight(cell.dummyView.frame));
        imageOffset = cell.dummyView.frame.size.height;
        NSString *urlString = [[NSString stringWithFormat:MAP_URL,item.eventAddress] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url =[NSURL URLWithString:urlString];
        [cell.dummyView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"page_bg"]] ;
    }else{
        cell.dummyView.hidden = YES;
    }
    [cell.backgroundGrayView setFrame:CGRectMake(10, 15, cell.bounds.size.width-20,20+ CGRectGetHeight(cell.headerView.frame)+5+detailViewHeight+5+imageOffset+15 )];
    cell.backgroundGrayView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.backgroundGrayView.layer.shadowOpacity = 0.5;
    cell.backgroundGrayView.layer.shadowOffset = CGSizeMake(-1.0, -1.0);
    cell.backgroundGrayView.layer.cornerRadius = 2.0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self heightForBasicCellAtIndexPath:indexPath];
}


- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static JHTimelineCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.timelineTV dequeueReusableCellWithIdentifier:@"JHTimelineCell"];
        if (sizingCell==nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"JHTimelineCell" owner:self options:Nil];
            sizingCell = [nib objectAtIndex:0];
            
        }
        
        
    });
    
     [self configureCell:sizingCell withItem:[_timelineItems objectAtIndex:indexPath.row]];
    JHTimelineItem *item = [_timelineItems objectAtIndex:indexPath.row];
    CGFloat imageOffset = 0;
    if ([item.dataType containsString:@"Image"]) {
        imageOffset = sizingCell.dummyView.bounds.size.height;
    }
    
    return sizingCell.backgroundGrayView.bounds.size.height + 20;
}



#pragma Scrollview delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.timelineTV.contentOffset.y<0){
        //it means table view is pulled down like refresh
        return;
    }
    else if(self.timelineTV.contentOffset.y >= (self.timelineTV.contentSize.height - self.timelineTV.bounds.size.height)) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        self.timelineTV.tableFooterView = activityView;
        if (!_loading) {
            int start = 0;
            if (_timelineItems != nil) {
                start = (int)[_timelineItems count];
            }
            [timelineAPI_ getTimelineDetails:[JHAppDelegate application].dataManager.token andLastCount:start withLoadingIndicator:NO];
            _loading = YES;

        }
        
            }
}

- (void)updateNotificationCount{
    int alertCount = [[JHAppDelegate application].dataManager getUnreadAlerts].count;
    int careTaskCount = [JHAppDelegate application].dataManager.careTasks.count;
    [self.alertCountLabel setText:[NSString stringWithFormat:@"%d",alertCount]];
    [self.careTaskCountLabel setText:[NSString stringWithFormat:@"%d",careTaskCount]];

}

-(IBAction)reportButtonPressed:(id)sender{
    JHReportViewController *vc = [[JHReportViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

-(IBAction)alertButtonPressed:(id)sender{
    JHRecentAlertsViewController *recentVC = [[JHRecentAlertsViewController alloc]initWithNibName:@"JHRecentAlertsViewController" bundle:nil];
    [self presentViewController:recentVC animated:YES completion:nil];
    
}

-(IBAction)careTaskButtonPressed:(id)sender{
    JHRecentCareTasksViewController *recentCT = [[JHRecentCareTasksViewController alloc]init];
    [self presentViewController:recentCT animated:YES completion:nil];
}

@end
