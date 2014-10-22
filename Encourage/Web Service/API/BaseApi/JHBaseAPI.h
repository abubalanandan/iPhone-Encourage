//
//  JHBaseAPI
//  Encourage
//
#import <Foundation/Foundation.h>
#import "JHWebService.h"

@protocol JHBaseAPIDelegate;

@interface JHBaseAPI : NSObject <JHWebServiceDelegate>{
    
    JHWebService *baseWebService_;
    id delegate_;
}
@property (nonatomic, assign) NSObject <JHBaseAPIDelegate> *delegate;
- (void) sendWebserviceRequest;

@end

@protocol JHBaseAPIDelegate

@optional

- (void)didFailDataFetch:(NSString *)error;
- (void)didFailedDataFetch:(NSString *)error;
- (void)didFailAuthentication:(NSString *)error;
- (void)didFailJsonException;
- (void)didFailNullException;
- (void)didRequestFailUnexpectedly;
- (void)didRequestTimedOut:(NSString *)error;
- (void)didFailNetwork:(NSString *)error;

@end
