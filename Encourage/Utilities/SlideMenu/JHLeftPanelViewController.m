//
//  JHLeftPanelViewController.m
//  Encourage
//
//  Created by Abu on 19/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHLeftPanelViewController.h"
#import "UIImageView+WebCache.h"
#import "JHLogoutAPI.h"
#import "JHLoginViewController.h"

@interface JHLeftPanelViewController ()
@property (weak,nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak,nonatomic) IBOutlet UILabel *profileNameTV;
@property (weak,nonatomic) IBOutlet UILabel *emailTV;
@property (nonatomic,assign) NSString *emailAddress;
@property (nonatomic,assign) NSString *userName;
@property (nonatomic,assign) NSString *profilePicName;
@end

@implementation JHLeftPanelViewController


- (id)init{
    self = [super init];
    if (self) {
        logoutAPI = [[JHLogoutAPI alloc]init];
        logoutAPI.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)setUpViewsWithName:(NSString *)name email:(NSString *)email andProfilePic:(NSString *)url{
    _userName = name;
    _emailAddress = email;
    
    _profilePicName = url;
   }

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpViewsWithName:[JHAppDelegate application].dataManager.username email:[JHAppDelegate application].dataManager.emailAddress andProfilePic:[JHAppDelegate application].dataManager.profilePicURL] ;
    [_profilePicImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:FILE_URL,[JHAppDelegate application].dataManager.token,_profilePicName]]placeholderImage:[UIImage imageNamed:@"head"]];
    _profileNameTV.text = _userName;
    _emailTV.text = _emailAddress;

}

-(IBAction)logout:(id)sender{
    [logoutAPI logout];
}


- (void)loggedOutSuccessfully{
    [[JHAppDelegate application].dataManager clearData];
    [JHAppDelegate application].timelineVC = nil;
    JHLoginViewController *vc = [[JHLoginViewController alloc]init];
    [[JHAppDelegate application].sidePanel removeFromParentViewController];
    [JHAppDelegate application].sidePanel = nil;
    [JHAppDelegate application].navController  = [[UINavigationController alloc]initWithRootViewController:vc];
    [JHAppDelegate application].window.rootViewController = [JHAppDelegate application].navController;
    [[JHAppDelegate application].window makeKeyAndVisible];
    //[[JHAppDelegate application].navController pushViewController:vc animated:YES];
}

- (void)logoutFailed:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
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

@end
