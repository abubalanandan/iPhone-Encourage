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

@interface JHReportViewController : JHBaseViewController <UIScrollViewDelegate, ABPeoplePickerNavigationControllerDelegate, JHReportAPIDelegate> {
    JHReportAPI *reportAPI;
}

@end
