//
//  JHError.h
//  Encourage
//
#import <Foundation/Foundation.h>
#import "KVCBaseObject.h"

@interface JHError : KVCBaseObject

@property (nonatomic, assign) NSString *code;
@property (nonatomic, assign) NSString *content;
@end
