//
//  DataProvider.h
//  Encourage
//

#import <Foundation/Foundation.h>

@interface JHDataManager : NSObject

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *profilePicURL;
@property (nonatomic,strong) NSString *deviceToken;
@property (nonatomic,strong) NSMutableArray *alerts;
@property (nonatomic,strong) NSMutableArray *careTasks;

- (void)clearData;
- (void)parseNotification:(NSString *)alertsNotification;

@end
