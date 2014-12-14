//
//  JHRecentAlertsViewController.m
//  Encourage
//
//  Created by Abu on 12/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHRecentAlertsViewController.h"
#import "JHRecentAlertsCellTableViewCell.h"
#import "JHAlert.h"
#import "JHAlertsListViewController.h"

@interface JHRecentAlertsViewController ()
@property IBOutlet UIButton *viewAllAlertsButton;
@property IBOutlet UITableView *recentAlertsTV;
@property IBOutlet UILabel *noAlertsLabel;
@property NSMutableArray *recentAlertsArray;
@end

@implementation JHRecentAlertsViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.recentAlertsArray = [[NSMutableArray alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.recentAlertsArray addObjectsFromArray:[[JHAppDelegate application].dataManager getUnreadAlerts]];
    
    //[self.recentAlertsTV setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"page_bg"]]];
    //[self.recentAlertsTV.backgroundView setBackgroundColor:[UIColor colorWithRed:220/255 green:226/255 blue:227/255 alpha:1]];
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = PAGE_BG_COLOR;
    
    [self.recentAlertsTV setBackgroundView:bgView];
    [self.recentAlertsTV reloadData];
    [self.viewAllAlertsButton setBackgroundColor:[UIColor darkGrayColor]];
    if ([JHAppDelegate application].dataManager.alerts.count ==0) {
        self.recentAlertsTV.hidden = YES;
        self.noAlertsLabel.hidden = NO;
    }
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

-(IBAction)closeButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)viewAllAlerts:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    JHAlertsListViewController *vc = [[JHAlertsListViewController alloc]init];
    [self.presentingViewController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recentAlertsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    JHRecentAlertsCellTableViewCell *cell =(JHRecentAlertsCellTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JHRecentAlertsCellTableViewCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
    }
    JHAlert *alert = [self.recentAlertsArray objectAtIndex:indexPath.row];
    cell.alertTitleLabel.text = alert.title;
    cell.dateLabel.text = alert.dateTime;
    cell.whiteView.layer.cornerRadius = 2.0;
    cell.whiteView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.whiteView.layer.shadowOffset = CGSizeMake(-1.0, -1.0);
    cell.whiteView.layer.shadowOpacity = 0.5;
    return cell;
}

@end
