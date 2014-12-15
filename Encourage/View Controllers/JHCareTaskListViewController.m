//
//  JHCareTaskListViewController.m
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHCareTaskListViewController.h"
#import "JHCareTaskDetailViewCell.h"
#import "JHCareTask.h"
#import "JHTimelineDetailItem.h"

@interface JHCareTaskListViewController ()
@property NSMutableArray *careTasks;
@property IBOutlet UITableView *careTasksTV;
@property JHCareTask *markedCareTask;
@end

@implementation JHCareTaskListViewController

-(id)init{
    self = [super init];
    if (self) {
        self.careTasks = [[NSMutableArray alloc]init];
        careTaskStatusAPI = [[JHCareTaskStatusAPI alloc]init];
        careTaskStatusAPI.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = PAGE_BG_COLOR;
    [self.careTasksTV setBackgroundView:bgView];
     NSArray *sortedArray = [[JHAppDelegate application].dataManager.careTasks sortedArrayUsingSelector:@selector(compare:)];
    [self.careTasks addObjectsFromArray: sortedArray];
    [self.careTasksTV reloadData];
    if (self.selectedCareTask) {
        NSInteger index = [self.careTasks indexOfObject:self.selectedCareTask];
        if (index==NSNotFound) {
            return;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.careTasksTV scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.careTasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    JHCareTaskDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JHCareTaskDetailViewCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
    }
    
    JHCareTask *item = (JHCareTask *)[self.careTasks objectAtIndex:indexPath.row];
    [self configureCell:cell withItem:item];
    cell.caretask = item;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (void)configureCell:(JHCareTaskDetailViewCell *)cell withItem:(JHCareTask *)item{
    NSArray *details = item.objects;
    CGFloat labelWidth = cell.detailsView.bounds.size.width/2 - 10;
    CGFloat headerHeight = CGRectGetMinY(cell.detailsView.frame);
    cell.careTaskTitleLabel.text = item.title;
    cell.dueDateLabel.text = item.careTaskDateTime;
    
    if ([item.careTaskType isEqualToString:CARETASK_TYPE_DOC]) {
        [cell.medImageView setImage:[UIImage imageNamed:@"doc"]];
    }else if ([item.careTaskType isEqualToString:CARETASK_TYPE_FOOD]){
        [cell.medImageView setImage: [UIImage imageNamed:@"lunch"]];
    }else{
        [cell.medImageView setImage:[UIImage imageNamed:@"med"]];
    }
    

    [[cell.detailsView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat detailViewHeight= 5;
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
    cell.detailsView.frame = CGRectMake(cell.detailsView.frame.origin.x, headerHeight, CGRectGetWidth(cell.detailsView.frame), detailViewHeight);
    
    CGPoint doneButtonOrigin= CGPointMake(CGRectGetMinX(cell.doneButton.frame), headerHeight+detailViewHeight+5);
    cell.doneButton.frame = CGRectMake(doneButtonOrigin.x, doneButtonOrigin.y, CGRectGetWidth(cell.doneButton.frame), CGRectGetHeight(cell.doneButton.frame));
    
    CGPoint notDoneButtonOrigin= CGPointMake(CGRectGetMinX(cell.notDoneButton.frame), headerHeight+detailViewHeight+5);
    cell.notDoneButton.frame = CGRectMake(notDoneButtonOrigin.x, notDoneButtonOrigin.y, CGRectGetWidth(cell.notDoneButton.frame), CGRectGetHeight(cell.notDoneButton.frame));
    
    [cell.whiteView setFrame:CGRectMake(10, 19, cell.bounds.size.width-20,detailViewHeight+headerHeight + CGRectGetHeight(cell.doneButton.frame)+10 )];
    cell.whiteView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.whiteView.layer.shadowOpacity = 0.5;
    cell.whiteView.layer.shadowOffset = CGSizeMake(-1.0, -1.0);
    cell.whiteView.layer.cornerRadius = 2.0;
    
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static JHCareTaskDetailViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.careTasksTV dequeueReusableCellWithIdentifier:@"JHCareTaskDetailViewCell"];
        if (sizingCell==nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"JHCareTaskDetailViewCell" owner:self options:Nil];
            sizingCell = [nib objectAtIndex:0];
            
        }
        
        
    });
    
    [self configureCell:sizingCell withItem:[self.careTasks objectAtIndex:indexPath.row]];
    
    return sizingCell.whiteView.bounds.size.height+20;
}

- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Care task action delegate

- (void)markCareTask:(JHCareTask *)caretask AsDone:(BOOL)done{
    NSString *status = done?@"D":@"ND";
    self.markedCareTask = caretask;
    [careTaskStatusAPI updateCareTaskStatus:caretask status:status];
}

- (void)didUpdateCaretaskStatus:(JHCareTaskStatusAPIResponse *)responseObj{
    [self.careTasks removeObject:self.markedCareTask];
    [[JHAppDelegate application].dataManager.careTasks removeObject:self.markedCareTask];
    self.markedCareTask = nil;
    [[JHAppDelegate application].timelineVC updateNotificationCount];
    [self.careTasksTV reloadData];
}

- (void)failedToUpdateCareTask{
    [JHHudController displayHUDWithTitle:@"Failure" withMessage:@"Failed to Update CareTask status" time:3];
}

@end
