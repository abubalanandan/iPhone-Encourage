//
//  JHActivityManager.m
//  Encourage
//
#import "JHActivityManager.h"
#import "JHAppDelegate.h"
#import "Utility.h"
#import "Constants.h"

#define GPS_POPUP_ACTIVITYINDICATOR_FRAME 20,5,60,60
#define PLEASE_WAIT_LABEL_FRAME 100,5,250,50
#define ACTIVITY_INDICTOR_FRAME 40,25,20,20
#define GPS_UNAVAILABLE_LABEL_FRAME 80,10,190,50
#define GPS_UNAVAILABLE_LABEL_FONT @"Helvetica"
#define GPS_UNAVAILABLE_LABEL_SIZE 13
#define GPS_UNAVAILABLE_LABEL_NO_OF_LINES 2

@implementation JHActivityManager

- (id)init {
	
    if(self = [super init]){
		
        activityIndicator1_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator4_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        largeActivityIndicator_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
    }
    return self;
}

- (void) startNormalActivityIndicator {
        
    activityIndicator1_.frame = CGRectMake(ACTIVITY_INDICATOR1_FRAME);
	[[JHAppDelegate application].window addSubview:activityIndicator1_];
    [activityIndicator1_ startAnimating];
}

- (void) stopNormalActivityIndicator {
    
    [activityIndicator1_ stopAnimating];
    [activityIndicator1_ removeFromSuperview];
}


- (void) startGPSActivityIndicator {
     
    if (!gpsUnavailableAlert_){
        
        gpsUnavailableAlert_ = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil,nil];
        [gpsUnavailableAlert_ show];
        gpsUnavailableLabel_ = [[UILabel alloc]initWithFrame:
                            CGRectMake(GPS_UNAVAILABLE_LABEL_FRAME)];
        gpsUnavailableLabel_.text = NSLocalizedString(@"GPS_Unavailable_Alert_text", @""); 
        gpsUnavailableLabel_.numberOfLines = GPS_UNAVAILABLE_LABEL_NO_OF_LINES;
        gpsUnavailableLabel_.font = [UIFont fontWithName:GPS_UNAVAILABLE_LABEL_FONT 
                                                size:GPS_UNAVAILABLE_LABEL_SIZE];
        gpsUnavailableLabel_.backgroundColor = [UIColor clearColor];
        gpsUnavailableLabel_.textColor = [UIColor whiteColor];
        largeActivityIndicator_.frame = CGRectMake(ACTIVITY_INDICTOR_FRAME);
        [gpsUnavailableAlert_ addSubview:largeActivityIndicator_];
        [largeActivityIndicator_ startAnimating];
        [gpsUnavailableAlert_ addSubview:gpsUnavailableLabel_];
    }
}

- (void) stopGPSActivityIndicator {
    
    if (gpsUnavailableAlert_)   {
        
        [gpsUnavailableAlert_ dismissWithClickedButtonIndex:0 animated:NO];
        gpsUnavailableAlert_ = nil;
    }
}

- (void) startGPSCheckActivityIndicator {
    
    if (!gpsCheckAlert_){
        
        gpsCheckAlert_ = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil,nil];
        [gpsCheckAlert_ show];
        gpsCheckLabel_ = [[UILabel alloc]initWithFrame:
                            CGRectMake(GPS_UNAVAILABLE_LABEL_FRAME)];
        gpsCheckLabel_.text = NSLocalizedString(@"Acquiring_Current_Location", @""); 
        gpsCheckLabel_.numberOfLines = GPS_UNAVAILABLE_LABEL_NO_OF_LINES;
        gpsCheckLabel_.font = [UIFont fontWithName:GPS_UNAVAILABLE_LABEL_FONT 
                                                size:GPS_UNAVAILABLE_LABEL_SIZE];
        gpsCheckLabel_.backgroundColor = [UIColor clearColor];
        gpsCheckLabel_.textColor = [UIColor whiteColor];
        largeActivityIndicator_.frame = CGRectMake(ACTIVITY_INDICTOR_FRAME);
        [gpsCheckAlert_ addSubview:largeActivityIndicator_];
        [largeActivityIndicator_ startAnimating];
        [gpsCheckAlert_ addSubview:gpsCheckLabel_];
    }
}

- (void) stopGPSCheckActivityIndicator {
    
    if (gpsCheckAlert_){
        
        [gpsCheckAlert_ dismissWithClickedButtonIndex:0 animated:NO];
        gpsCheckAlert_ = nil;
    }
}



- (void) startPleaseWaitActivityIndicator {
    
    if (!pleaseWaitAlert_){
        
        pleaseWaitAlert_ = [[UIAlertView alloc]initWithTitle:@"Loading" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil,nil];
        
        [pleaseWaitAlert_ show];
        pleaseWaitLabel_ = [[UILabel alloc]initWithFrame:CGRectMake(PLEASE_WAIT_LABEL_FRAME)];
        pleaseWaitLabel_.text = NSLocalizedString(@"Please_Wait_Message", @""); 
        pleaseWaitLabel_.backgroundColor = [UIColor clearColor];
        pleaseWaitLabel_.textColor = [UIColor blackColor];
        largeActivityIndicator_.frame = CGRectMake(ACTIVITY_INDICTOR_FRAME);
        [pleaseWaitAlert_ addSubview:largeActivityIndicator_];
        [largeActivityIndicator_ startAnimating];
        [pleaseWaitAlert_ addSubview:pleaseWaitLabel_];
    }
}

- (void) stopPleaseWaitActivityIndicator {
     
    if (pleaseWaitAlert_){
    
        [pleaseWaitAlert_ dismissWithClickedButtonIndex:0 animated:NO];
        pleaseWaitAlert_ = nil;
    }
}

- (void) displayAlertWithtitle:(NSString *)title message:(NSString *)message delegate:(id)delegate firstButtonTitle:(NSString *)firstButtonTitle secondButtonTitle:(NSString *)secondButtonTitle tag:(int)tag{
    
    alertView_ = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:firstButtonTitle otherButtonTitles:secondButtonTitle, nil];
    alertView_.tag = tag;
    [alertView_ show];
    
}

- (void)dismissAlert {

    if (alertView_) {
        
        [alertView_ dismissWithClickedButtonIndex:0 animated:NO];
        alertView_ = nil;
        
        }
}

@end
