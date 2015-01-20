//
//  DataProvider.h
//  Encourage
//

#import <Foundation/Foundation.h>

@interface JHDataManager : NSObject

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *profilePicURL;
@property (nonatomic,strong) NSString *emailAddress;
@property (nonatomic,strong) NSString *deviceToken;
@property (nonatomic,strong) NSMutableArray *alerts;
@property (nonatomic,strong) NSMutableArray *careTasks;
@property (nonatomic,strong) NSMutableArray *chosenContactNames;
@property (nonatomic,strong) NSMutableArray *chosenContactEmails;
@property (nonatomic,strong) NSMutableDictionary *imageHeights;

- (void)clearData;
- (void)parseNotification:(NSString *)alertsNotification;
- (NSArray *)getUnreadAlerts;
- (void)clearContacts;

@end
