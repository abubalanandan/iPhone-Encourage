//
//  DataProvider.m
//  Encourage
//
#import "JHDataManager.h"
#import "SBJSON.h"
#import "Constants.h"
#import "JHAlert.h"
#import "JHCareTask.h"
#define JSON_RESPONSE_DESCRIPTION_KEY @"responseDescription"



@implementation JHDataManager
- (id)init{
    self = [super init];
    if (self) {
        self.alerts = [[NSMutableArray alloc]init];
        self.careTasks = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)clearData{
    self.token = nil;
    self.profilePicURL = nil;
    self.username = nil;
    self.alerts = nil;
    self.careTasks = nil;
}

- (void)parseNotification:(NSString *)alertsNotification{
    SBJSON *parser = [[SBJSON alloc] init];
    NSDictionary *jsonContent = [parser objectWithString:alertsNotification error:nil] ;
    
   	
    
    
    
    if(!jsonContent || ([jsonContent objectForKey:JSON_RESPONSE_DESCRIPTION_KEY]==[NSNull null] )){
        
                
    }else {
        if ([jsonContent objectForKey:RESPONSE_DESCRIPTION_KEY]) {
            if ([[[jsonContent objectForKey:RESPONSE_DESCRIPTION_KEY]objectForKey:NOTIFICATION_TYPE_KEY] isEqualToString:NOTIFICATION_TYPE_ALERT]) {
                id responseObj;
                Class responseObjClass = objc_getClass([@"JHAlert" cStringUsingEncoding:NSASCIIStringEncoding]);
                
                responseObj = [responseObjClass objectForDictionary:jsonContent];
                JHAlert *alert = (JHAlert *)responseObj;
                if (![self.alerts containsObject:alert]) {
                    [self.alerts addObject:alert];
                }
            }else if([[[jsonContent objectForKey:RESPONSE_DESCRIPTION_KEY]objectForKey:NOTIFICATION_TYPE_KEY] isEqualToString:NOTIFICATION_TYPE_CARETASK]){
                id responseObj;
                Class responseObjClass = objc_getClass([@"JHCareTask" cStringUsingEncoding:NSASCIIStringEncoding]);
                
                responseObj = [responseObjClass objectForDictionary:jsonContent];
                JHCareTask *careTask = (JHCareTask *)responseObj;
                if (!([self.careTasks containsObject:careTask])) {
                    [self.careTasks addObject:careTask];
                }
            }
        }
        int unreadAlertCount = 0;
        for (JHAlert *alert in self.alerts) {
            if ([alert.readStatus isEqualToString:NOTIFICATION_UNREAD]) {
                unreadAlertCount++;
            }
        }
        [[JHAppDelegate application].timelineVC updateAlert:unreadAlertCount AndCareTask:(int)self.careTasks.count];
    }
        
    


}

- (NSArray *)getUnreadAlerts{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for(JHAlert *alert in self.alerts){
        if ([alert.readStatus isEqualToString:NOTIFICATION_UNREAD]) {
            [array addObject:alert];
        }
    }
    return array;
}

@end
