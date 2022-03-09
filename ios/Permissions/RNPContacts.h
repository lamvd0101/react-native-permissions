//
//  RNPContacts.h
//  React
//
//  Created by LAP01378 on 09/03/2022.
//

#import <Foundation/Foundation.h>
#import "RCTConvert+RNPStatus.h"

@interface RNPContacts : NSObject

+ (NSString *)getStatus;
+ (void)request:(void (^)(NSString *))completionHandler;
@end
