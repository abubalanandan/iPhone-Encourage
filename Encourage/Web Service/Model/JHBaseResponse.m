//
//  JHBaseResponse.m
//  Encourage
//

#import "JHBaseResponse.h"
#import "JHError.h"

@implementation JHBaseResponse


@synthesize responseDescription = responseDescription_;

- (id)init {
	
    if(self =[super init]){
		
    }
    return self;
}

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"responseDescription"]) {
        return [NSString stringWithCString:class_getName([JHResponeMessage class]) encoding:NSUTF8StringEncoding];;
  
    }
    return nil;
}
@end
