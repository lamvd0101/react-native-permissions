//
//  RNPLocation.h
//  React
//
//  Created by LAP01378 on 09/03/2022.
//

#import <Foundation/Foundation.h>
#import "RCTConvert+RNPStatus.h"

@interface RNPLocation : NSObject

+ (NSString *)getStatus;
- (void)request:(NSString *)type completionHandler:(void (^)(NSString *))completionHandler;

@end
