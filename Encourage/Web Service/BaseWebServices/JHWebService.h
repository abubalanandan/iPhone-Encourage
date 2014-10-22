//
//  IDBaseWebService.h
//  Encourage
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JHBaseRequest.h"
#import "JHBaseResponse.h"
#import "JHResponeMessage.h"
#import "KVCBaseObject.h"


@protocol JHWebServiceDelegate;

@interface JHWebService : NSObject {
    NSObject <JHWebServiceDelegate> *delegate_;
	ASIFormDataRequest *request_;
}

@property(nonatomic, assign) NSObject <JHWebServiceDelegate> *delegate;
@property(nonatomic, retain) NSString *responseClassName;

- (void)performPostRequest:(NSString*)url withRequestObject:(JHBaseRequest*)requestObj;
//- (void) postData:(IDUploadDataRequest *)data;

@end

@protocol JHWebServiceDelegate

- (void)didReceiveData:(JHBaseResponse *)responseObj;
- (void)didReceiveFailedStatusCode:(JHResponeMessage*)message;
- (void)didRequestFailDataFetch:(JHResponeMessage*)message;
- (void)didReceiveNetworkError:(NSString *)errorMessage;



@optional

- (void)requestTimedOut:(NSString *)error;
- (void)didRequestFailAuthentication:(JHResponeMessage*)message;
- (void)didReceiveJSONException;
- (void)didFailUnexpectedly;


@end
