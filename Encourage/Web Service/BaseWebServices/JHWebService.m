//
//  IDBaseWebService.m
//  Encourage
//

#import "JHWebService.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NSObject+SBJSON.h"
#import "Utility.h"


#define JSON_RESPONSE_STATUS_KEY @"responseCode"
#define JSON_RESPONSE_SUCCESS_STATUS @"OK"
#define JSON_RESPONSE_FAIL_STATUS @"FAILED"
#define JSON_RESPONSE_DATA_KEY @"data"
#define JSON_RESPONSE_DESCRIPTION_KEY @"responseDescription"
#define JSON_RESPONSE_ERROR_CONTENT @"content"
#define JSON_RESPONSE_INFORMATION_MESSAGE_KEY @"informationMessages"
#define ACCEPT_KEY @"accept"
#define AUTHENTICATION_ERROR_CODE 401
#define LOGIN_HEADER @"Authorization"
#define CONTENT_TYPE_VALUE @"application/json"
#define CONTENT_TYPE @"Content-Type"
#define RESPONSE_ALERT @"Failed to fetch data"
#define RESPONSE_MESSAGES @"responseDescription"
#define NULL_VALUE @""

#define HTTP_TIME_OUT 50

@implementation JHWebService

@synthesize delegate = delegate_;
@synthesize responseClassName = responseClassName_;

- (id) init {
    self = [super init];
    if(self) {
        delegate_ = nil;
    } 
    return self;
}

- (void) performPostRequest:(NSString*)url withRequestObject:(KVCBaseObject *)requestObj{
    
	if ([Utility isNetworkAvailable]) {

		NSURL *requestUrl = [NSURL URLWithString:url];
		
		if(request_) {
			[request_ setDelegate:nil];
			[request_ release];
		}
		request_ = [[ASIFormDataRequest requestWithURL:requestUrl] retain];
		[request_ setDelegate:self];
		[request_ setTimeOutSeconds:HTTP_TIME_OUT];
		[request_ addRequestHeader:ACCEPT_KEY value:CONTENT_TYPE_VALUE];
        NSString * contentToSend = [requestObj objectToJson];
        [request_ addRequestHeader:CONTENT_TYPE value:CONTENT_TYPE_VALUE];
		[request_ setPostBody:(NSMutableData *)[contentToSend dataUsingEncoding:[NSString defaultCStringEncoding]]];
		[request_ startAsynchronous];
	} else {
		[delegate_ didReceiveNetworkError:NSLocalizedString(@"ReachabilityMessage",@"")];
	}
}

//- (void) postData:(IDUploadDataRequest *)data{
//    
//    if ([Utility isNetworkAvailable]) {
//        
//        NSString * url = [NSString stringWithFormat:IMAGE_UPLOAD_URL, BASE_URL];
//        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
//        [request setRequestMethod:@"POST"];
//    
//        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data"];
//        [request addRequestHeader:@"Content-Type" value:contentType];
//    
//        [request setFile:data.imageFile forKey:@"imageFile"];
//        [request setPostValue:data.imageType forKey:@"imageType"];
//    
//        [request startSynchronous];
//            
//        NSString *receivedResponse = nil;
//        receivedResponse = [request responseString];
//        
//        SBJSON *parser = [[SBJSON alloc] init];
//        NSDictionary *jsonContent = [parser objectWithString:receivedResponse error:nil];
//        id responseObj;
//        Class responseObjClass = objc_getClass([responseClassName_ cStringUsingEncoding:NSASCIIStringEncoding]);
//        
//        responseObj = [responseObjClass objectForDictionary:jsonContent];
//        
//        if(!jsonContent || ([jsonContent objectForKey:JSON_RESPONSE_DESCRIPTION_KEY]==[NSNull null] || [[jsonContent objectForKey:JSON_RESPONSE_DESCRIPTION_KEY]count]==0 )){
//        
//            if([delegate_ respondsToSelector:@selector(didReceiveJSONException)])
//                [delegate_ didReceiveJSONException];
//        
//        }else if ([[jsonContent objectForKey:JSON_RESPONSE_STATUS_KEY] isEqualToString:JSON_RESPONSE_SUCCESS_STATUS]){
//        
//        
//            if([delegate_ respondsToSelector:@selector(didReceiveData:)])
//                [delegate_ didReceiveData:responseObj];
//        
//        
//        }else if([[jsonContent objectForKey:JSON_RESPONSE_STATUS_KEY] isEqualToString:JSON_RESPONSE_FAIL_STATUS]) {
//        
//        
//            JHResponeMessage * responseMessageObj = (JHResponeMessage *)[JHResponeMessage objectForDictionary:[jsonContent objectForKey:RESPONSE_MESSAGES]];
//        
//        
//            if([delegate_ respondsToSelector:@selector(didReceiveFailedStatusCode:)])
//                [delegate_ didReceiveFailedStatusCode:responseMessageObj];
//        } else if([delegate_ respondsToSelector:@selector(didFailUnexpectedly)]) {
//            [delegate_ didFailUnexpectedly];
//        }
//        [parser release];
//    }else{
//        
//        [delegate_ didReceiveNetworkError:NSLocalizedString(@"ReachabilityMessage",@"")];
//    }
//}

#pragma mark --
#pragma mark ASIHTTPRequestDelegateMethods

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSString *receivedResponse = nil;
    receivedResponse = [[request responseString] retain];
    
    if ([request.url.absoluteString containsString:@"Logout"]) {
        receivedResponse = @"{\"responseCode\":\"OK\",\"responseDescription\":{}}";
    }
    SBJSON *parser = [[SBJSON alloc] init];
	NSDictionary *jsonContent = [[parser objectWithString:receivedResponse error:nil] retain];
       
   	id responseObj;    
    Class responseObjClass = objc_getClass([responseClassName_ cStringUsingEncoding:NSASCIIStringEncoding]);
    
        responseObj = [responseObjClass objectForDictionary:jsonContent];
    
    

	if(!jsonContent || ([jsonContent objectForKey:JSON_RESPONSE_DESCRIPTION_KEY]==[NSNull null] /*|| [[jsonContent objectForKey:JSON_RESPONSE_DESCRIPTION_KEY]count]==0*/ )){

        if([delegate_ respondsToSelector:@selector(didReceiveJSONException)])
            [delegate_ didReceiveJSONException];
        
    }else if ([[jsonContent objectForKey:JSON_RESPONSE_STATUS_KEY] isEqualToString:JSON_RESPONSE_SUCCESS_STATUS]){
               

        if([delegate_ respondsToSelector:@selector(didReceiveData:)])
            [delegate_ didReceiveData:responseObj];

        
    }else if([[jsonContent objectForKey:JSON_RESPONSE_STATUS_KEY] isEqualToString:JSON_RESPONSE_FAIL_STATUS]) {
        
       
        JHResponeMessage * responseMessageObj = (JHResponeMessage *)[JHResponeMessage objectForDictionary:[jsonContent objectForKey:RESPONSE_MESSAGES]];


        if([delegate_ respondsToSelector:@selector(didReceiveFailedStatusCode:)])
            [delegate_ didReceiveFailedStatusCode:responseMessageObj];
	} else if([delegate_ respondsToSelector:@selector(didFailUnexpectedly)]) {
            [delegate_ didFailUnexpectedly];
    }
    
    
    [jsonContent release];
    [parser release];
	[receivedResponse release];     
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    
    NSError *error = [request error];
    
    NSString *receivedResponse = nil;
    receivedResponse = [[request responseString] retain];
    SBJSON *parser = [[SBJSON alloc] init];
	NSDictionary *jsonContent = [[parser objectWithString:receivedResponse error:nil] retain];
   	
    JHResponeMessage * responseMessageObj = (JHResponeMessage *)[JHResponeMessage objectForDictionary:[jsonContent objectForKey:RESPONSE_MESSAGES]];
    
    
    if([error code] == ASIRequestTimedOutErrorType || [error code] == ASIConnectionFailureErrorType){
        // The following AND condition check is made to ensure that the responseTimedOut delegate is not called for web services that is being called periodically. 
        // In this case its the bookingStatus w/s.
        if([delegate_ respondsToSelector:@selector(requestTimedOut:)])
        {
            [delegate_ requestTimedOut:[error localizedDescription]];
            
            return;
        }
    }
	//To check authentication failure.
	int statusCode = [request responseStatusCode];
	if(statusCode == AUTHENTICATION_ERROR_CODE) {
        if([delegate_ respondsToSelector:@selector(didRequestFailAuthentication:)]){
            [delegate_ didRequestFailAuthentication:responseMessageObj];
            return;
        }
	}
	[delegate_ didRequestFailDataFetch:responseMessageObj];
} 


#pragma mark -
#pragma mark dealloc

- (void)dealloc {
	if(request_)
		request_.delegate = nil;
    if (delegate_)
		delegate_ = nil;
	[request_ release];
    [super dealloc];
}

@end

