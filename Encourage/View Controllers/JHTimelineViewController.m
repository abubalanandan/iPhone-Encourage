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
    
    _loading = YES;
    [timelineAPI_ getTimelineDetails:[JHAppDelegate application].dataManager.token andLastCount:0 withLoadingIndicator:YES];
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.timelineTV.bounds];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(backgroundView.frame), CGRectGetHeight(backgroundView.frame))];
    iv.image = [UIImage imageNamed:@"page_bg"];
    [backgroundView addSubview:iv];
    [self.timelineTV setBackgroundView:backgroundView];
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
        [_timelineItems addObjectsFromArray:response.objects];
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
    [[cell.detailsView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat originY= 5;
    for (JHTimelineDetailItem *detail in details) {
        CGFloat labelHeight = [self requiredHeightWithKey:detail.key andValue:detail.value forCellWidth:labelWidth];
        UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, originY, labelWidth, labelHeight)];
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelWidth+20, originY, labelWidth, labelHeight)];
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
        originY +=labelHeight+5;
    }
    cell.detailsView.frame = CGRectMake(cell.detailsView.frame.origin.x, 5, CGRectGetWidth(cell.detailsView.frame), originY);
    CGFloat imageOffset = 0;
    if ([item.dataType containsString:@"Image"]) {
        cell.dummyView.hidden = NO;
        cell.dummyView.frame = CGRectMake(CGRectGetMinX(cell.dummyView.frame), originY+5, CGRectGetWidth(cell.dummyView.frame), CGRectGetHeight(cell.dummyView.frame));
        imageOffset = cell.dummyView.frame.size.height;
        [cell.dummyView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:FILE_URL,[JHAppDelegate application].dataManager.token,item.documentActualName]]] ;
    }else{
        cell.dummyView.hidden = YES;
    }
    [cell.backgroundImageView setFrame:CGRectMake(0, 0, cell.bounds.size.width, originY + imageOffset +10)];
    cell.detailsView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.detailsView.layer.shadowOpacity = 0.5;
    cell.detailsView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
}


- (CGFloat)requiredHeightWithKey:(NSString *)key andValue:(NSString *)value forCellWidth:(CGFloat)cellWidth{
    CGSize constrainedSize = CGSizeMake(cellWidth  , 9999);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:12.0], NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:key attributes:attributesDictionary];
    
    CGFloat requiredKeyHeight = CGRectGetHeight([string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil]);
    
    NSMutableAttributedString *valueString = [[NSMutableAttributedString alloc]initWithString:value attributes:attributesDictionary];
    CGFloat requiredValueHeight =CGRectGetHeight( [valueString boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil]);
    
    return (requiredKeyHeight>requiredValueHeight)?requiredKeyHeight:requiredValueHeight;
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
    
    return sizingCell.detailsView.bounds.size.height + imageOffset + 10;
   // return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
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
            [timelineAPI_ getTimelineDetails:[JHAppDelegate application].dataManager.token andLastCount:_lastCount withLoadingIndicator:NO];
            _loading = YES;

        }
        
            }
}

-(IBAction)reportButtonPressed:(id)sender{
    
}

@end
