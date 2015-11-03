//
//  BAKKeychain.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/24/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKKeychain.h"

static const NSString *BAKAuthTokenKey = @"BAKAuthTokenKey";

@interface BAKKeychain ()

@property (nonatomic) NSString *authToken;

@end

@implementation BAKKeychain

- (void)storeAuthToken:(NSString *)authToken error:(NSError *__autoreleasing *)error {
    NSDictionary *attributes = @{ (__bridge id)kSecValueData: [authToken dataUsingEncoding:NSUTF8StringEncoding] };
    NSError *fetchError = nil;
    [self fetchAuthTokenWithError:&fetchError];
    if (fetchError.code == errSecItemNotFound) {
        [self addAuthTokenWithAttributes:attributes error:error];
    } else if (!fetchError) {
        [self updateAuthTokenWithAttributes:attributes error:error];
    } else {
        if (fetchError.code != errSecSuccess && error) {
            *error = [self errorWithCode:fetchError.code];
        }
    }
}

- (void)addAuthTokenWithAttributes:(NSDictionary *)attributes error:(NSError *__autoreleasing *)error {
    NSMutableDictionary *query = [[self query] mutableCopy];
    [query addEntriesFromDictionary:attributes];
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    if (status != errSecSuccess && error) {
        *error = [self errorWithCode:status];
    }
}

- (void)updateAuthTokenWithAttributes:(NSDictionary *)attributes error:(NSError *__autoreleasing *)error {
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)(self.query), (__bridge CFDictionaryRef)(attributes));
    if (status != errSecSuccess && error) {
        *error = [self errorWithCode:status];
    }
}

- (void)deleteAuthToken:(NSError *__autoreleasing *)error {
    OSStatus status = noErr;
    NSDictionary *query = [self query];
    status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != errSecSuccess && error) {
        *error = [self errorWithCode:status];
    }
}

- (NSString *)fetchAuthTokenWithError:(NSError *__autoreleasing *)error {
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)self.searchQuery, &result);
    if (status != errSecSuccess && error) {
        *error = [self errorWithCode:status];
        return nil;
    }
    return [[NSString alloc] initWithData:(__bridge_transfer NSData *)result encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)query {
    return @{
             (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
             (__bridge id)kSecAttrLabel: BAKAuthTokenKey,
             };
}

- (NSDictionary *)searchQuery {
    NSMutableDictionary *query = [[self query] mutableCopy];
    query[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    query[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    return [query copy];
}

- (NSError *)errorWithCode:(NSInteger)code {
    NSString *message = self.errorDescriptions[@(code)] ?: @"There was an error.";
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : message };
    return [NSError errorWithDomain:@"BAKKeychainErrorDomain" code:code userInfo:userInfo];
}

- (NSDictionary *)errorDescriptions {
    return @{
             @(errSecUnimplemented): @"Function or operation not implemented.",
             @(errSecParam): @"One or more parameters passed to a function were not valid.",
             @(errSecAllocate): @"Failed to allocate memory.",
             @(errSecNotAvailable): @"No keychain is available. You may need to restart your computer.",
             @(errSecDuplicateItem): @"The specified item already exists in the keychain.",
             @(errSecItemNotFound): @"The specified item could not be found in the keychain.",
             @(errSecInteractionNotAllowed): @"User interaction is not allowed.",
             @(errSecDecode): @"Unable to decode the provided data.",
             @(errSecAuthFailed): @"The user name or passphrase you entered is not correct.",
             };
}

@end
