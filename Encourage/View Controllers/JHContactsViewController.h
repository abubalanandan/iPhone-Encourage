//
//  JHContactsViewController.h
//  Encourage
//
//  Created by kiran vs on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHReportViewController.h"

@protocol JHContactDataDelegate;

@interface JHContactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    
    IBOutlet UITableView *contactsTableView;
    
}

@property (nonatomic, strong) NSArray *contactsArray;
@property (nonatomic, assign) id <JHContactDataDelegate> delegate;

- (id)initWithDelegate:(id <JHContactDataDelegate>) delegate;

@end

@protocol JHContactDataDelegate <NSObject>

- (void)didSelectContacts:(NSMutableArray *)names andContacts:(NSMutableArray *)email;

@end