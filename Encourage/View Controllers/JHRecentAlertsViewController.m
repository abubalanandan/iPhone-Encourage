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

@interface JHRecentAlertsViewController ()
@property IBOutlet UIButton *viewAllAlertsButton;
@property IBOutlet UITableView *recentAlertsTV;
@property IBOutlet UILabel *noAlertsLabel;
@end

@implementation JHRecentAlertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [JHAppDelegate application].dataManager.alerts.count;
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
    JHAlert *alert = [[JHAppDelegate application].dataManager.alerts objectAtIndex:indexPath.row];
    cell.alertTitleLabel.text = alert.title;
    cell.dateLabel.text = alert.dateTime;
    cell.whiteView.layer.cornerRadius = 2.0;
    cell.whiteView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.whiteView.layer.shadowOffset = CGSizeMake(-1.0, -1.0);
    cell.whiteView.layer.shadowOpacity = 0.5;
    return cell;
}

@end
