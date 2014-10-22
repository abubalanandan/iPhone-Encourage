//
//  JHResponeMessages.h
//  Encourage
//

#import <Foundation/Foundation.h>
#import "KVCBaseObject.h"

@interface JHResponeMessage : KVCBaseObject


@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *errorDescription;

@end
