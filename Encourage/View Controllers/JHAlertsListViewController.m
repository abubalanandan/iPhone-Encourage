//
//  JHAlertsListViewController.m
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHAlertsListViewController.h"
#import "JHAlertDetailViewCell.h"
#import "UIImageView+WebCache.h"

@interface JHAlertsListViewController ()
@property BOOL loading;
@property BOOL start;
@end

@implementation JHAlertsListViewController

-(id)init{
    self = [super init];
    if (self) {
        self.alerts = [[NSMutableArray alloc]init];
        alertsAPI = [[JHAlertsAPI alloc]init];
        alertsAPI.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = PAGE_BG_COLOR;
    [self.alertsTV setBackgroundView:bgView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    _loading = YES;
    _start = YES;
    [alertsAPI getAlertDetails:[JHAppDelegate application].dataManager.token andLastCount:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- IBActions
- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- Alert Details API Delegate

- (void)didReceiveAlertsDetails:(JHAlertsAPIResponse *)response{
    _loading = NO;
    [_activity stopAnimating];
    for (JHAlert *alert in response.objects) {
        if (![self.alerts containsObject:alert]) {
            [self.alerts addObject:alert];
        }
    }
    NSArray *sortedArray = [self.alerts sortedArrayUsingSelector:@selector(compare:)];
    [self.alerts removeAllObjects];
    [self.alerts addObjectsFromArray:sortedArray];
    [self.alertsTV reloadData];
    if (_start) {
        if (self.selectedAlert!=nil) {
            NSInteger index = [self.alerts indexOfObject:self.selectedAlert];
            if (index!=NSNotFound) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                [self.alertsTV scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
        }
        _start = NO;
    }
}

#pragma mark - Table View Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.alerts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    JHAlertDetailViewCell *cell = (JHAlertDetailViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JHAlertDetailViewCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];

    }
    JHAlert *alert = [self.alerts objectAtIndex:indexPath.row];
    [self configureCell:cell withItem:alert];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (void)configureCell:(JHAlertDetailViewCell *)cell withItem:(JHAlert *)item{
    NSString *details = item.details;
    CGFloat labelWidth = cell.detailsView.bounds.size.width - 20;
    CGFloat headerHeight = CGRectGetMinY(cell.detailsView.frame);
    cell.alertTitleLabel.text = item.title;
    cell.dateTimeLabel.text = item.dateTime;
    CGFloat urlViewHeight = CGRectGetHeight(cell.urlDetailView.frame);
    
    
    
    if ([item.contentType rangeOfString:@"Link"].location!=NSNotFound) {
        cell.urlDetailView.hidden = NO;
        cell.urlHeader.text = item.urlHeader;
        cell.urlPreviewLabel.text = item.details;
        NSURL *imageURL = [NSURL URLWithString:item.image];
        [cell.urlPreviewImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"page_bg"]];
        cell.detailsView.hidden = YES;
        [cell.whiteView setFrame:CGRectMake(10, 19, cell.bounds.size.width-20,urlViewHeight+headerHeight + 20 )];
    }else{
    [[cell.detailsView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.urlDetailView.hidden=YES;
 
    CGFloat detailViewHeight= 5;
    CGFloat labelHeight = [Utility requiredHeightWithString:details forCellWidth:labelWidth ];
    UILabel *detailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, detailViewHeight, labelWidth, labelHeight)];
    detailsLabel.numberOfLines=0;
    detailsLabel.font = [UIFont boldSystemFontOfSize:12.0];
    detailsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailsLabel.text = item.details;
    [cell.detailsView addSubview:detailsLabel];
    
    detailViewHeight += labelHeight+5;
    CGFloat imageOffset = 0;
    if ([item.contentType rangeOfString:@"Image"].location!=NSNotFound) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, detailViewHeight, 280, 280)];
        [cell.detailsView addSubview:imageView];
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:FILE_URL,[JHAppDelegate application].dataManager.token,item.documentActualName]];
        [imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"page_bg"]];
        imageOffset += imageView.bounds.size.height + 10;
    }else if ([item.contentType rangeOfString:@"Map"].location!=NSNotFound) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, detailViewHeight, 280, 280)];
        [cell.detailsView addSubview:imageView];
        NSString *urlString = [[NSString stringWithFormat:MAP_URL,item.eventAddress]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *imageURL = [NSURL URLWithString:urlString];
        [imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"page_bg"]];
        imageOffset += imageView.bounds.size.height + 10;
    }
    cell.detailsView.frame = CGRectMake(cell.detailsView.frame.origin.x, headerHeight, CGRectGetWidth(cell.detailsView.frame), detailViewHeight+imageOffset);
    [cell.whiteView setFrame:CGRectMake(10, 19, cell.bounds.size.width-20,detailViewHeight+headerHeight+imageOffset + 15 )];

    }
    
    cell.whiteView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.whiteView.layer.shadowOpacity = 0.5;
    cell.whiteView.layer.shadowOffset = CGSizeMake(-1.0, -1.0);
    cell.whiteView.layer.cornerRadius = 2.0;
    
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static JHAlertDetailViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.alertsTV dequeueReusableCellWithIdentifier:@"JHAlertDetailViewCell"];
        if (sizingCell==nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"JHAlertDetailViewCell" owner:self options:Nil];
            sizingCell = [nib objectAtIndex:0];
            
        }
        
        
    });
    
    [self configureCell:sizingCell withItem:[self.alerts objectAtIndex:indexPath.row]];
    
    return sizingCell.whiteView.bounds.size.height+20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JHAlert *alert = [self.alerts objectAtIndex:indexPath.row];
    if ([alert.contentType rangeOfString:@"Link"].location != NSNotFound) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:alert.url]];
    }
}


#pragma mark -- ScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.alertsTV.contentOffset.y<0){
        //it means table view is pulled down like refresh
        return;
    }
    else if(self.alertsTV.contentOffset.y >= (self.alertsTV.contentSize.height - self.alertsTV.bounds.size.height)) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        self.alertsTV.tableFooterView = activityView;
        if (!_loading) {
            int start = 0;
            if (self.alerts != nil) {
                start = (int)[self.alerts count];
            }
            [alertsAPI getAlertDetails:[JHAppDelegate application].dataManager.token andLastCount:start];
            _loading = YES;
            
        }
        
    }
}


@end
