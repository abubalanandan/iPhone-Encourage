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

@end

@implementation JHAlertsListViewController

-(id)init{
    self = [super init];
    if (self) {
        self.alerts = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.alerts addObjectsFromArray:[[JHAppDelegate application].dataManager getUnreadAlerts]];
    [self.alertsTV reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    
    
    if ([item.contentType containsString:@"Link"]) {
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
    if ([item.contentType containsString:@"Image"]) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, detailViewHeight, 280, 280)];
        [cell.detailsView addSubview:imageView];
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:FILE_URL,[JHAppDelegate application].dataManager.token,item.documentActualName]];
        [imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"page_bg"]];
        imageOffset += imageView.bounds.size.height + 10;
    }else if ([item.contentType containsString:@"Map"]) {
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
@end
