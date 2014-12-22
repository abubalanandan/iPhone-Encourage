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
#import "JHContactsViewController.h"
#import "JHHudController.h"

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
@property (nonatomic, strong) NSArray *selectedEmailsArray;
@property (nonatomic, strong) NSArray *selectedNamesArray;
@property (nonatomic, assign) BOOL shouldInformCC;

@end

@implementation JHReportViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    reportAPI = [[JHReportAPI alloc] init];
    reportAPI.delegate = self;
    imageAPI = [[JHImageUploadAPI alloc]init];
    imageAPI.delegate = self;
    
    _sliderSwitch = [DVSwitch switchWithStringsArray:@[@"SICK",@"EMOTIONAL",@"IMAGE",@"MAP"]];
    _sliderSwitch.font = [UIFont boldSystemFontOfSize:10];
    [_sliderSwitch setFrame:CGRectMake(0, 0, self.sliderView.bounds.size.width, self.sliderView.bounds.size.height)];
    _sliderSwitch.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:60.0/255.0 alpha:1];
    _sliderSwitch.sliderColor = [UIColor blueColor];
    _sliderSwitch.labelTextColorInsideSlider = [UIColor colorWithRed:16.0/255.0 green:28.0/255.0 blue:60.0/255.0 alpha:1];
    _sliderSwitch.labelTextColorOutsideSlider = [UIColor whiteColor];
    _sliderSwitch.cornerRadius = 0;
    _sliderSwitch.sliderOffset = 5;
    _sliderSwitch.delegate = self;
    [_sliderSwitch setWillBePressedHandler:^(NSUInteger index) {
        [self scrollToSelectedIndex:index];
    }];
    
    [self.sliderView addSubview:_sliderSwitch];
    
    _addressBookController.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableScrolling) name:@"kEnableContainerScrollNotification" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [self addPagesToContainer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - DVSwitch Methods

- (void)changeSegmentedControlToIndex:(NSUInteger)index {
    
    if (APP_DELEGATE.shouldEnableScrolling) {
        [_sliderSwitch forceSelectedIndex:index animated:YES];
    }
    if (index > 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kClearAllButtonSelectionNotification" object:nil];
    }
}

- (BOOL)shouldChangeIndex:(NSInteger)index{
    if (APP_DELEGATE.shouldEnableScrolling)
        return YES;
    return NO;
}

#pragma mark -
#pragma mark - UIScrollView Delegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([self getCurrentPage] > 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kClearAllButtonSelectionNotification" object:nil];
    }
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
    if (APP_DELEGATE.shouldEnableScrolling){
        [self.containerScrollView setContentOffset:CGPointMake(index * 320, 0) animated:YES];
        if (index > 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kClearAllButtonSelectionNotification" object:nil];
        }

    }
}

- (void)enableScrolling {
    self.containerScrollView.scrollEnabled = YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (APP_DELEGATE.shouldEnableScrolling) {
        self.containerScrollView.scrollEnabled = YES;
    }
    else {
        self.containerScrollView.scrollEnabled = NO;
    }
    
}

- (UIView *)setFrameForView:(UIView *)view atIndex:(int)index {
    
    view.frame = CGRectMake(index * 320, 0, 320, 340);
    return view;
}

- (NSUInteger)getCurrentPage {
 
    return floor(self.containerScrollView.contentOffset.x/320.0);
}

- (BOOL)shouldReport {

    switch ([self getCurrentPage]) {
        case 0:
        case 1:
        {
            if ([[_pageOne.getPageOneStatus objectForKey:@"events"] count] > 0 || [[_pageTwo.getPageTwoStatus objectForKey:@"events"] count] > 0) {
                return YES;
            }
            break;
        }
        case 2: {
            if (_pageThree.getImage != nil && [[_pageThree.getData objectForKey:@"description"] length] > 0) {
                return YES;
            }
            break;
        }
        case 3: {
            if ([[_pageFour.getPageFourData objectForKey:@"eventName"] length] > 0 && [[_pageFour.getPageFourData objectForKey:@"eventDesc"] length] > 0 && [[_pageFour.getPageFourData objectForKey:@"eventAddress"] length] > 0) {
                return YES;
            }
        }
        default:break;
    }
    return NO;
}

#pragma mark -
#pragma mark - IBActions

- (IBAction)reportAction:(id)sender {
    
    if ([self shouldReport] == NO) {
        
        if ([self getCurrentPage] == 0 || [self getCurrentPage] == 1) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please choose a sickness/emotion" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill in all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        switch ([self getCurrentPage]) {
            case 0:
            case 1:
            {
                [self sendReportForFirstAndSecondPages];
                break;
            }
            case 2: {
                
               UIImage *img = _pageThree.getImage;
                if (img != nil)
                {
                    [JHHudController displayHUDWithMessage:@"Uploading Image..."];
                    [self performSelectorInBackground:@selector(saveImageData) withObject:nil];
                }
                
                break;
            }
            case 3: {
                [self sendReportForFourthPage];
                break;
            }
            default:
                break;
        }
    }
}

- (IBAction)addContacts:(id)sender {
    
    CFErrorRef *error = nil;
    
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    NSMutableArray* items = [NSMutableArray array];
    if (accessGranted) {
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByFirstName);
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
        
        
        
        for (int i = 0; i < nPeople; i++)
        {
            
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            
            //get First Name and Last Name
            
            NSMutableDictionary *contact = [NSMutableDictionary dictionary];
            [contact setObject:(__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty) forKey:@"name"];
            [contact setObject:[NSString stringWithFormat:@"%@ %@", [contact objectForKey:@"name"], (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty)] forKey:@"name"];

            //get Contact email
            
            ABMultiValueRef multiEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            for (CFIndex i=0; i<ABMultiValueGetCount(multiEmails); i++) {
                CFStringRef contactEmailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
                [contact setObject:(__bridge NSString *)contactEmailRef forKey:@"email"];
                break;
            }
            if ([[contact objectForKey:@"email"] length] != 0) {
                [items addObject:contact];
            }
        }
    }
    
    JHContactsViewController *contactsVC = [[JHContactsViewController alloc] initWithDelegate:self];
    contactsVC.contactsArray = [[NSArray alloc] initWithArray:items];
    contactsVC.delegate = self;
    [self.navigationController pushViewController:contactsVC animated:YES];
            
}

- (IBAction)informCareCircle:(id)sender {
    
    if (checkBoxButton.selected) {
        
        self.shouldInformCC = NO;
        [checkBoxButton setSelected:NO];
    }
    else {
        
        self.shouldInformCC = YES;
        [checkBoxButton setSelected:YES];
    }
}

- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - Webservice Methods

- (void)sendReportForFirstAndSecondPages {
    
    /*
     {"dateTime":"2014-10-31 16:22:43","timeZone" : "Asia/Kolkata", "eventName":"Complaint", "eventData":["Can't sleep","Dry Skin","Shortness of Breath","Tingling sensation","Worried","Can't sleep"], "description":"","reportType":"complaint","informCC":"yes","nimycMails":["shylu@gmail.com"],"nimycPersons":["shylu"],"addToMyCcs":"yes","token":"c39743a867ad557e1000be334711edad"}
     */
    JHReportAPIRequest *reportRequest = [[JHReportAPIRequest alloc] init];
    reportRequest.timeZone = [NSString stringWithFormat:@"%@", [[NSTimeZone localTimeZone] name]];
    reportRequest.eventData = [self getEventData];
    reportRequest.eventDescription = ([self getCurrentPage] == 0) ? [_pageOne.getPageOneStatus objectForKey:@"eventDescription"] : [_pageTwo.getPageTwoStatus objectForKey:@"eventDescription"];
    reportRequest.reportType = REPORT_TYPE_COMPLAINT;
    reportRequest.informCC = (self.shouldInformCC) ? @"yes" : @"no";;
    reportRequest.nimycMails = [self getNimycMails];
    reportRequest.nimycPersons = [self getNimycPersons];
    reportRequest.addToMyCcs = @"yes";
    reportRequest.eventDate = [_pageOne.getPageOneStatus objectForKey:@"date"];
    
    [reportAPI sendReport:reportRequest];
}

- (void)sendReportForThirdPage:(NSDictionary *)data {
    
    /*
     {"dateTime":"2014-10-31 17:20:12","timeZone":"Asia/Kolkata","eventName":"Arrival entered an if drawing request","reportType":"image","token":"c39743a867ad557e1000be334711edad","fileActualName":"61885D04-B09B-42A4-B92C-4011D505ABBB.JPG","fileName":"","fileType":"image/jpeg","informCC":"yes","nimycMails":["shylu@gmail.com"],"nimycPersons":["shylu"],"addToMyCcs":"yes"}
     */
    JHReportAPIRequest *reportRequest = [[JHReportAPIRequest alloc] init];
    reportRequest.timeZone = [NSString stringWithFormat:@"%@", [[NSTimeZone localTimeZone] name]];
    reportRequest.eventName = [data objectForKey:@"description"];
    reportRequest.reportType = REPORT_TYPE_IMAGE;
    reportRequest.informCC = (self.shouldInformCC) ? @"yes" : @"no";
    reportRequest.nimycMails = [self getNimycMails];
    reportRequest.nimycPersons = [self getNimycPersons];
    reportRequest.addToMyCcs = @"yes";
    reportRequest.fileActualName = [data objectForKey:@"fileName"];
    reportRequest.eventDate = [_pageOne.getPageOneStatus objectForKey:@"date"];
    
    [reportAPI sendReport:reportRequest];
}

- (void)sendReportForFourthPage {
    
    /*
     {"dateTime":"2014-10-31 17:26:58","timeZone":"Asia/Kolkata","eventName":"tourist","reportType":"map","token":"bfad24bf95e447bdac33cff1c3381ada","eventAddress":"shamirpet,Rangareddi district of Telangana 500095, India","description":"","informCC":"yes","nimycMails":["shylu@gmail.com"],"nimycPersons":["shylu"],"addToMyCcs":"yes"}
     
     */
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:_pageFour.getPageFourData];
    
    if (dict == nil) {
        return;
    }
    JHReportAPIRequest *reportRequest = [[JHReportAPIRequest alloc] init];
    reportRequest.timeZone = [NSString stringWithFormat:@"%@", [[NSTimeZone localTimeZone] name]];
    reportRequest.eventName = [dict objectForKey:@"eventName"];
    reportRequest.eventAddress = [dict objectForKeyedSubscript:@"eventAddress"];
    reportRequest.eventDescription = [dict objectForKeyedSubscript:@"eventDesc"];
    reportRequest.reportType = REPORT_TYPE_MAP;
    reportRequest.informCC = (self.shouldInformCC) ? @"yes" : @"no";
    reportRequest.nimycMails = [self getNimycMails];
    reportRequest.nimycPersons = [self getNimycPersons];
    reportRequest.addToMyCcs = @"yes";
    reportRequest.eventDate = [_pageOne.getPageOneStatus objectForKey:@"date"];
    
    [reportAPI sendReport:reportRequest];
}

#pragma mark -
#pragma mark - Private Methods

- (NSArray *)getEventData {
    
    NSArray *eventsArray = [NSArray arrayWithObjects:@"Sore Throat", @"Tired", @"Back Pain", @"Dizziness", @"Can't Sleep", @"Joint Pain", @"Dry Skin", @"Nose Bleed", @"Shortness of Breath", @"Breathless", @"Tingling Sensation", @"Other", @"Worried", @"Anxious", @"Depressed", @"Angry", @"Sad", @"Happy", @"Restless", nil];
    
    NSMutableArray *events = [NSMutableArray arrayWithArray:[[_pageOne getPageOneStatus] objectForKey:@"events"]];
    [events addObjectsFromArray:[[_pageTwo getPageTwoStatus] objectForKey:@"events"]];
    
    NSMutableArray *selectedEvents = [NSMutableArray arrayWithCapacity:0];
    for (NSString *event in events) {
        [selectedEvents addObject:[eventsArray objectAtIndex:[event integerValue]]];
    }
    
    return selectedEvents;
}

- (NSArray *)getNimycMails {
    
    if (self.selectedEmailsArray) {
        return self.selectedEmailsArray;
    }
    return [NSArray array];
}

- (NSArray *)getNimycPersons {
    
    if (self.selectedNamesArray) {
        return self.selectedNamesArray;
    }
    return [NSArray array];
}

#pragma mark -
#pragma mark - ReportAPI Delegate

- (void)didReceiveReportResponse:(JHReportAPIResponse *)response {
    
    [JHHudController hideAllHUDs];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)failedToPostReport:(NSString *)message{
    [Utility showOkAlertWithTitle:@"Error" message:message];
}
#pragma mark -

- (void)didSelectContacts:(NSMutableArray *)names andContacts:(NSMutableArray *)email {
   
    self.selectedEmailsArray = [NSArray arrayWithArray:email];
    self.selectedNamesArray = [NSArray arrayWithArray:names];
}

#pragma mark -
#pragma mark - ImageUploadDelegate

- (void)didUploadImage:(JHImageUploadAPIResponse *)responseObj {
    
    if (responseObj == nil) {
        [JHHudController hideAllHUDs];
    }
    NSMutableDictionary * data = [NSMutableDictionary dictionaryWithDictionary:_pageThree.getData];
    [data setObject:responseObj.fileActualName forKey:@"fileName"];
    [self sendReportForThirdPage:data];
    
}

- (void)imageUploadFailed:(NSString *)message{
    [Utility showOkAlertWithTitle:@"Error" message:message];
}

- (void)saveImageData {
    
    UIImage *img = _pageThree.getImage;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"test.png" ];
    NSData* data = UIImagePNGRepresentation(img);
    BOOL success = [data writeToFile:path atomically:YES];
    if (success) {
        [imageAPI performSelectorOnMainThread:@selector(uploadImageWithPath:) withObject:path waitUntilDone:YES];
    }
}

@end
