//
//  JHLeftPanelViewController.h
//  Encourage
//
//  Created by Abu on 19/11/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHLogoutAPI.h"

@interface JHLeftPanelViewController : UIViewController<JHLogoutAPIDelegate>{
    JHLogoutAPI *logoutAPI;
}
- (void)setUpViewsWithName:(NSString *)name email:(NSString *)email andProfilePic:(NSString *)url;
-(IBAction)logout:(id)sender;
@end
