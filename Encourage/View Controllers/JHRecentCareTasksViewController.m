//
//  JHRecentCareTasksViewController.m
//  Encourage
//
//  Created by Abu on 12/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHRecentCareTasksViewController.h"
#import "JHRecentCareTasksCell.h"
#import "JHCareTask.h"
#import "JHCareTaskListViewController.h"

@interface JHRecentCareTasksViewController ()
@property IBOutlet UILabel *noCaretasksLabel;
@property IBOutlet UITableView *careTasksTV;
@property IBOutlet UIButton *viewAllCTButton;
@property NSMutableArray *recentCareTasks;
@property JHCareTask *markedCareTask;

@end

@implementation JHRecentCareTasksViewController

- (id)init{
    self = [super init];
    if(self){
        self.recentCareTasks = [[NSMutableArray alloc]init];
        careTaskStatusAPI = [[JHCareTaskStatusAPI alloc]init];
        careTaskStatusAPI.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewAllCTButton setBackgroundColor:[UIColor darkGrayColor]];
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = PAGE_BG_COLOR;
    [self.careTasksTV setBackgroundView:bgView];
    [self.recentCareTasks addObjectsFromArray:[JHAppDelegate application].dataManager.careTasks];
    [self.careTasksTV reloadData];
    if (self.recentCareTasks.count==0) {
        self.noCaretasksLabel.hidden = NO;
        self.careTasksTV.hidden = YES;
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)viewAllCareTasks:(id)sender{
    if ([self.recentCareTasks count]!=0) {
        JHCareTaskListViewController *vc = [[JHCareTaskListViewController alloc]init];
        [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
        [self.presentingViewController presentViewController:vc animated:YES completion:nil];
        
        
    }
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recentCareTasks.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    JHRecentCareTasksCell *cell = (JHRecentCareTasksCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JHRecentCareTasksCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];

    }
    JHCareTask *careTask = [self.recentCareTasks objectAtIndex:indexPath.row];
    cell.careTaskTitleLabel.text = careTask.title;
    cell.dueDateLabel.text = careTask.careTaskDateTime;
    if ([careTask.careTaskType isEqualToString:CARETASK_TYPE_DOC]) {
        [cell.medImageView setImage:[UIImage imageNamed:@"doc"]];
    }else if ([careTask.careTaskType isEqualToString:CARETASK_TYPE_FOOD]){
        [cell.medImageView setImage: [UIImage imageNamed:@"lunch"]];
    }else{
        [cell.medImageView setImage:[UIImage imageNamed:@"med"]];
    }
    cell.whiteView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.whiteView.layer.cornerRadius = 2.0;
    cell.whiteView.layer.shadowOpacity = 0.5;
    cell.whiteView.layer.shadowOffset = CGSizeMake(-1, -1);
    cell.caretask = careTask;
    cell.delegate = self;
    return cell;
}


#pragma mark - Recent CareTask Cell Delegate

- (void)markCareTask:(JHCareTask *)caretask AsDone:(BOOL)done{
    NSString *status = done?@"D":@"ND";
    self.markedCareTask = caretask;
    [careTaskStatusAPI updateCareTaskStatus:caretask status:status];
}


#pragma mark - CareTask Status API delegate

- (void)didUpdateCaretaskStatus:(JHCareTaskStatusAPIResponse *)responseObj{
    [self.recentCareTasks removeObject:self.markedCareTask];
    [[JHAppDelegate application].dataManager.careTasks removeObject:self.markedCareTask];
    self.markedCareTask = nil;
    [self.careTasksTV reloadData];

}

- (void)failedToUpdateCareTask{
    [JHHudController displayHUDWithTitle:@"Failure" withMessage:@"Failed to update caretask status" time:3];
}
@end
