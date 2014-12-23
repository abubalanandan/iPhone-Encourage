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
@property JHAlert *markedAlert;
@property (nonatomic,strong) JASidePanelController *presentingVC;
@end

@implementation JHRecentAlertsViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.recentAlertsArray = [[NSMutableArray alloc]init];
        alertStatusAPI = [[JHAlertStatusAPI alloc]init];
        alertStatusAPI.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presentingVC = (JASidePanelController *) self.presentingViewController;
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

#pragma mark -- IBActions

-(IBAction)closeButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)viewAllAlerts:(id)sender{
    
    if (SYSTEM_VERSION_LESS_THAN(@"8.0") ) {
        [self dismissViewControllerAnimated:YES completion:^{
            JHAlertsListViewController *vc = [[JHAlertsListViewController alloc]init];
            
            [self.presentingVC presentViewController:vc animated:YES completion:nil];
            
        }];

    }else{
            [self.presentingViewController dismissViewControllerAnimated:YES  completion:nil];
            JHAlertsListViewController *vc = [[JHAlertsListViewController alloc]init];
            
            [self.presentingViewController presentViewController:vc animated:YES completion:nil];

        
        

    }
    


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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JHAlert *alert = [self.recentAlertsArray objectAtIndex:indexPath.row];
    self.markedAlert = alert;
    [alertStatusAPI markAlertAsRead:alert.alertKey];
}


#pragma mark -- Alert Status API delegate

-(void)markedAlertSuccessfully{
    [self.recentAlertsArray removeObject:self.markedAlert];
    NSInteger index = [[JHAppDelegate application].dataManager.alerts indexOfObject:self.markedAlert];
    JHAlert *alert = [[JHAppDelegate application].dataManager.alerts objectAtIndex:index];
    alert.readStatus = NOTIFICATION_READ;
    [[JHAppDelegate application].timelineVC updateNotificationCount];
    self.markedAlert = nil;
    JHAlertsListViewController *vc = [[JHAlertsListViewController alloc]init];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [JHHudController displayHUDWithMessage:@"Loading Alert Details..."];
    [self.presentingViewController presentViewController:vc animated:YES completion:^{
        [JHHudController hideAllHUDs];
    }];
}

- (void)failedToMarkAlert:(NSString *)message{
    self.markedAlert = nil;
    [Utility showOkAlertWithTitle:@"Error" message:message];
}
@end
