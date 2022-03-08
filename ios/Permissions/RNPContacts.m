//
//  RNPContacts.m
//  Pods
//
//  Created by LAP01378 on 09/03/2022.
//

#import "RNPContacts.h"
#import <AddressBook/AddressBook.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
@import Contacts;
#endif

@implementation RNPContacts

+ (NSString *)getStatus
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
    int status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusAuthorized:
            return RNPStatusAuthorized;
        case CNAuthorizationStatusDenied:
            return RNPStatusDenied;
        case CNAuthorizationStatusRestricted:
            return RNPStatusRestricted;
        default:
            return RNPStatusUndetermined;
    }
#else
    int status = ABAddressBookGetAuthorizationStatus();
    switch (status) {
        case kABAuthorizationStatusAuthorized:
            return RNPStatusAuthorized;
        case kABAuthorizationStatusDenied:
            return RNPStatusDenied;
        case kABAuthorizationStatusRestricted:
            return RNPStatusRestricted;
        default:
            return RNPStatusUndetermined;
    }
#endif
}

@end
