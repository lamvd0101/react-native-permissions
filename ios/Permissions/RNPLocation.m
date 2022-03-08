//
//  RNPLocation.m
//  Pods
//
//  Created by LAP01378 on 09/03/2022.
//

#import "RNPLocation.h"
#import <CoreLocation/CoreLocation.h>


@interface RNPLocation() <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (copy) void (^completionHandler)(NSString *);
@end

@implementation RNPLocation

+ (NSString *)getStatus
{
    if (![CLLocationManager locationServicesEnabled]) {
        return RNPStatusRestricted;
    }

    int status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            return RNPStatusAuthorized;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return RNPStatusAuthorized;
        case kCLAuthorizationStatusDenied:
            return RNPStatusDenied;
        case kCLAuthorizationStatusRestricted:
            return RNPStatusRestricted;
        default:
            return RNPStatusUndetermined;
    }
}
@end
