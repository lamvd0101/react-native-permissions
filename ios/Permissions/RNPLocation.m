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

- (void)request:(NSString*)type completionHandler:(void (^)(NSString *))completionHandler
{
    if (![CLLocationManager locationServicesEnabled]) {
        return completionHandler(RNPStatusRestricted);
    }

    NSString *status = [RNPLocation getStatus];
    if (status == RNPStatusUndetermined) {
        self.completionHandler = completionHandler;

        if (self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
        }

        if ([type isEqualToString:@"always"]) {
            [self.locationManager requestAlwaysAuthorization];
        } else {
            [self.locationManager requestWhenInUseAuthorization];
        }
    } else {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse && [type isEqualToString:@"always"]) {
            completionHandler(RNPStatusDenied);
        } else {
            completionHandler(status);
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status != kCLAuthorizationStatusNotDetermined) {
        if (self.locationManager) {
            self.locationManager.delegate = nil;
            self.locationManager = nil;
        }

        if (self.completionHandler) {
            //for some reason, checking permission right away returns denied. need to wait a tiny bit
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                self.completionHandler([RNPLocation getStatus]);
                self.completionHandler = nil;
            });
        }
    }
}

@end
