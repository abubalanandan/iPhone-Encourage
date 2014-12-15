//
//  JHReportViewController.m
//  Encourage
//
//  Created by Abu on 13/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHReportViewController.h"
#import "DVSwitch.h"
#import "JHReportPageOne.h"
#import "JHReportPageTwo.h"
#import "JHReportPageThree.h"
#import "JHReportPageFour.h"
#import "JHReportAPIRequest.h"

@interface JHReportViewController ()
@property IBOutlet UIView *sliderView;
@property IBOutlet UIImageView *bgView;
@property IBOutlet UIScrollView *containerScrollView;

@property DVSwitch *sliderSwitch;
@property (nonatomic, strong) JHReportPageOne *pageOne;
@property (nonatomic, strong) JHReportPageTwo *pageTwo;
@property (nonatomic, strong) JHReportPageThree *pageThree;
@property (nonatomic, strong) JHReportPageFour *pageFour;

@property (nonatomic, readwrite) ABAddressBookRef addressBook;
@property (nonatomic, strong) ABPeoplePickerNavigationController *addressBookController;
@property (nonatomic, strong) NSMutableArray *contactsArray;

@end

@implementation JHReportViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _sliderSwitch = [DVSwitch switchWithStringsArray:@[@"SICK",@"EMOTIONAL",@"IMAGE",@"MAP"]];
    _sliderSwitch.font = [UIFont boldSystemFontOfSize:10];
    [_sliderSwitch setFrame:CGRectMake(0, 0, self.sliderView.bounds.size.width, self.sliderView.bounds.size.height)];
    _sliderSwitch.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:60.0/255.0 alpha:1];
    _sliderSwitch.sliderColor = [UIColor blueColor];
    _sliderSwitch.labelTextColorInsideSlider = [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:60.0/255.0 alpha:1];
    _sliderSwitch.labelTextColorOutsideSlider = [UIColor whiteColor];
    _sliderSwitch.cornerRadius = 0;
    _sliderSwitch.sliderOffset = 5;
    [_sliderSwitch setWillBePressedHandler:^(NSUInteger index) {
        [self scrollToSelectedIndex:index];
    }];
    [self.sliderView addSubview:_sliderSwitch];
    
    [self addPagesToContainer];
    
    _addressBookController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - DVSwitch Methods

- (void)changeSegmentedControlToIndex:(NSUInteger)index {
    [_sliderSwitch forceSelectedIndex:index animated:YES];
}

#pragma mark -
#pragma mark - UIScrollView Delegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self changeSegmentedControlToIndex:[self getCurrentPage]];
}

- (void)addPagesToContainer {
    
    _pageOne = [[JHReportPageOne alloc] init];
    _pageTwo = [[JHReportPageTwo alloc] init];
    _pageThree = [[JHReportPageThree alloc] init];
    _pageFour = [[JHReportPageFour alloc] init];
    
    [self addChildViewController:_pageOne];
    [self addChildViewController:_pageTwo];
    [self addChildViewController:_pageThree];
    [self addChildViewController:_pageFour];
    
    [self.containerScrollView setContentSize:CGSizeMake(1280, CGRectGetHeight(self.containerScrollView.frame))];
    [self.containerScrollView addSubview:[self setFrameForView:_pageOne.view atIndex:0]];
    [self.containerScrollView addSubview:[self setFrameForView:_pageTwo.view atIndex:1]];
    [self.containerScrollView addSubview:[self setFrameForView:_pageThree.view atIndex:2]];
    [self.containerScrollView addSubview:[self setFrameForView:_pageFour.view atIndex:3]];
    
    self.containerScrollView.pagingEnabled = YES;
}

- (void)scrollToSelectedIndex:(NSUInteger)index {
    [self.containerScrollView setContentOffset:CGPointMake(index * 320, 0) animated:YES];
}

- (UIView *)setFrameForView:(UIView *)view atIndex:(int)index {
    
    view.frame = CGRectMake(index * 320, 0, 320, 340);
    return view;
}

- (NSUInteger)getCurrentPage {
 
    return floor(self.containerScrollView.contentOffset.x/320.0);
}

#pragma mark -
#pragma mark - IBActions

- (IBAction)reportAction:(id)sender {
    
    switch ([self getCurrentPage]) {
        case 0:
        case 1:
        {
            [self sendReportForFirstAndSecondPages];
            break;
        }
        case 2: {
            
            
            break;
        }
        case 3: {
            break;
        }
        default:
            break;
    }
    
}

- (IBAction)addContacts:(id)sender {
    
    _addressBookController = [[ABPeoplePickerNavigationController alloc] init];
    [_addressBookController setPeoplePickerDelegate:self];
    [self presentViewController:_addressBookController animated:YES completion:nil];
}

- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - ABPeoplePickerNavigationController Delegates

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    
    // Initialize a mutable dictionary and give it initial values.
    NSMutableDictionary *contactInfoDict = [[NSMutableDictionary alloc]
                                            initWithObjects:@[@"", @"", @"", @"", @"", @"", @"", @"", @""]
                                            forKeys:@[@"firstName", @"lastName", @"homeEmail", @"workEmail"]];
    
    // Use a general Core Foundation object.
    CFTypeRef generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    // Get the first name.
    if (generalCFObject) {
        [contactInfoDict setObject:(__bridge NSString *)generalCFObject forKey:@"firstName"];
        CFRelease(generalCFObject);
    }
    
    // Get the last name.
    generalCFObject = ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (generalCFObject) {
        [contactInfoDict setObject:(__bridge NSString *)generalCFObject forKey:@"lastName"];
        CFRelease(generalCFObject);
    }
    
    
    
    // Get the e-mail addresses as a multi-value property.
    ABMultiValueRef emailsRef = ABRecordCopyValue(person, kABPersonEmailProperty);
    for (int i=0; i<ABMultiValueGetCount(emailsRef); i++) {
        CFStringRef currentEmailLabel = ABMultiValueCopyLabelAtIndex(emailsRef, i);
        CFStringRef currentEmailValue = ABMultiValueCopyValueAtIndex(emailsRef, i);
        
        if (CFStringCompare(currentEmailLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
            [contactInfoDict setObject:(__bridge NSString *)currentEmailValue forKey:@"homeEmail"];
        }
        
        if (CFStringCompare(currentEmailLabel, kABWorkLabel, 0) == kCFCompareEqualTo) {
            [contactInfoDict setObject:(__bridge NSString *)currentEmailValue forKey:@"workEmail"];
        }
        
        CFRelease(currentEmailLabel);
        CFRelease(currentEmailValue);
    }
    CFRelease(emailsRef);
    

    // Initialize the array if it's not yet initialized.
    if (_contactsArray == nil) {
        _contactsArray = [[NSMutableArray alloc] init];
    }
    // Add the dictionary to the array.
    [_contactsArray addObject:contactInfoDict];
    
//    // Reload the table view data.
//    [self.tableView reloadData];
//    
    // Dismiss the address book view controller.
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
}


-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    
    // Initialize a mutable dictionary and give it initial values.
    NSMutableDictionary *contactInfoDict = [[NSMutableDictionary alloc]
                                            initWithObjects:@[@"", @"", @"", @"", @"", @"", @"", @"", @""]
                                            forKeys:@[@"firstName", @"lastName", @"homeEmail", @"workEmail"]];
    
    // Use a general Core Foundation object.
    CFTypeRef generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    // Get the first name.
    if (generalCFObject) {
        [contactInfoDict setObject:(__bridge NSString *)generalCFObject forKey:@"firstName"];
        CFRelease(generalCFObject);
    }
    
    // Get the last name.
    generalCFObject = ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (generalCFObject) {
        [contactInfoDict setObject:(__bridge NSString *)generalCFObject forKey:@"lastName"];
        CFRelease(generalCFObject);
    }
    
    
    
    // Get the e-mail addresses as a multi-value property.
    ABMultiValueRef emailsRef = ABRecordCopyValue(person, kABPersonEmailProperty);
    for (int i=0; i<ABMultiValueGetCount(emailsRef); i++) {
        CFStringRef currentEmailLabel = ABMultiValueCopyLabelAtIndex(emailsRef, i);
        CFStringRef currentEmailValue = ABMultiValueCopyValueAtIndex(emailsRef, i);
        
        if (CFStringCompare(currentEmailLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
            [contactInfoDict setObject:(__bridge NSString *)currentEmailValue forKey:@"homeEmail"];
        }
        
        if (CFStringCompare(currentEmailLabel, kABWorkLabel, 0) == kCFCompareEqualTo) {
            [contactInfoDict setObject:(__bridge NSString *)currentEmailValue forKey:@"workEmail"];
        }
        
        CFRelease(currentEmailLabel);
        CFRelease(currentEmailValue);
    }
    CFRelease(emailsRef);
    
    
    // Initialize the array if it's not yet initialized.
    if (_contactsArray == nil) {
        _contactsArray = [[NSMutableArray alloc] init];
    }
    // Add the dictionary to the array.
    [_contactsArray addObject:contactInfoDict];
    
    //    // Reload the table view data.
    //    [self.tableView reloadData];
    //
    // Dismiss the address book view controller.
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - Webservice Methods

- (void)sendReportForFirstAndSecondPages {
    
    /*
     {"dateTime":"2014-10-31 16:22:43","timeZone" : "Asia/Kolkata", "eventName":"Complaint", "eventData":["Can't sleep","Dry Skin","Shortness of Breath","Tingling sensation","Worried","Can't sleep"], "description":"","reportType":"complaint","informCC":"yes","nimycMails":["shylu@gmail.com"],"nimycPersons":["shylu"],"addToMyCcs":"yes","token":"c39743a867ad557e1000be334711edad"}
     */
    JHReportAPIRequest *reportRequest = [[JHReportAPIRequest alloc] init];
    reportRequest.dateTime = [NSString stringWithFormat:@"%@", [NSDate date]];
    reportRequest.timeZone = [NSString stringWithFormat:@"%@", [NSTimeZone localTimeZone]];
    reportRequest.eventName = @"";
    reportRequest.eventData = [self getEventData];
    reportRequest.eventDescription = @"";
    reportRequest.reportType = REPORT_TYPE_COMPLAINT;
    reportRequest.informCC = NO;
    reportRequest.nimycMails = [self getNimycMails];
    reportRequest.nimycPersons = [self getNimycPersons];
    reportRequest.addToMyCcs = NO;
    
    [reportAPI sendReport:reportRequest];
}

#pragma mark -
#pragma mark - Private Methods

- (NSArray *)getEventData {
    
    NSArray *eventsArray = [NSArray arrayWithObjects:@"Sore Throat", @"Tired", @"Back Pain", @"Dizziness", @"Can't Sleep", @"Joint Pain", @"Dry Skin", @"Nose Bleed", @"Shortness of Breath", @"Worried", @"Anxious", @"Depressed", @"Angry", @"Sad", @"Happy", @"Restless", nil];
    
    NSMutableArray *events = [NSMutableArray arrayWithArray:[[_pageOne getPageOneStatus] objectForKey:@"events"]];
    [events addObjectsFromArray:[[_pageTwo getPageTwoStatus] objectForKey:@"events"]];
    
    NSMutableArray *selectedEvents = [NSMutableArray arrayWithCapacity:0];
    for (NSString *event in events) {
        [selectedEvents addObject:[eventsArray objectAtIndex:[event integerValue]]];
    }
    
    return selectedEvents;
}

- (NSArray *)getNimycMails {
    
    return nil;
}

- (NSArray *)getNimycPersons {
    
    return nil;
}

#pragma mark -
#pragma mark - ReportAPI Delegate

- (void)didReceiveReportResponse:(JHReportAPIResponse *)response {
    
}

@end
