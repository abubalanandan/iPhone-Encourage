//
//  JHBaseResponse.h
//  Encourage
//

#import <Foundation/Foundation.h>
#import "JHResponeMessage.h"
#import "KVCBaseObject.h"

@interface JHBaseResponse : KVCBaseObject {
    
}

@property (nonatomic, strong) JHResponeMessage *responseDescription;

@end
