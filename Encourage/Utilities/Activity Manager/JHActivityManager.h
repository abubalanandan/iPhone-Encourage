//
//  JHActivityManager.h
//  Encourage
//

#import <Foundation/Foundation.h>

@interface JHActivityManager : NSObject {
    
    UIActivityIndicatorView *activityIndicator1_;
    UIImageView             *activityIndicator2_;
    UIActivityIndicatorView *activityIndicator4_;
    UIImageView             *frameView_;
    UILabel *textLabel_;
    UIActivityIndicatorView *largeActivityIndicator_;
    UIAlertView             *pleaseWaitAlert_;
    UILabel                 *pleaseWaitLabel_;
    UIAlertView             *gpsUnavailableAlert_;
    UILabel                 *gpsUnavailableLabel_;
    UIAlertView             *gpsCheckAlert_;
    UILabel                 *gpsCheckLabel_;
    UIAlertView             *alertView_;
 
}

- (void)startNormalActivityIndicator;
- (void)stopNormalActivityIndicator;
- (void)startGPSActivityIndicator;
- (void)stopGPSActivityIndicator;

- (void)startPleaseWaitActivityIndicator;
- (void)stopPleaseWaitActivityIndicator;
- (void)startGPSCheckActivityIndicator;
- (void)stopGPSCheckActivityIndicator;
- (void) displayAlertWithtitle:(NSString *)title message:(NSString *)message delegate:(id)delegate firstButtonTitle:(NSString *)firstButtonTitle secondButtonTitle:(NSString *)secondButtonTitle tag:(int)tag;
- (void)dismissAlert;

@end
