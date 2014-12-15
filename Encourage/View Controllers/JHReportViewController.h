//
//  JHReportViewController.h
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHBaseViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import "JHReportAPI.h"
#import "JHImageUploadAPI.h"
#import "JHContactsViewController.h"

@protocol JHContactDataDelegate;

@interface JHReportViewController : JHBaseViewController <UIScrollViewDelegate, JHReportAPIDelegate, JHContactDataDelegate, JHImageUploadDelegate> {
    JHReportAPI *reportAPI;
    JHImageUploadAPI *imageAPI;
    
    IBOutlet UIButton *checkBoxButton;
}

@property (nonatomic, assign) id <JHContactDataDelegate> contactDelegate;
@end

