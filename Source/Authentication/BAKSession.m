//
//  BAKSession.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/22/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKSession.h"
#import "BAKUser.h"
#import "BAKKeychain.h"

NSString *const BAKPasswordKey = @"BAKPasswordKey";

@interface BAKLoggedOutSession : BAKSession @end

@interface BAKSession ()

@property (nonatomic) BAKKeychain *keychain;


@end

@implementation BAKSession

static BAKSession *_currentSession = nil;

+ (instancetype)currentSession {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        NSString *cachedAuthToken = [[BAKKeychain new] fetchAuthTokenWithError:&error];
        if (cachedAuthToken) {
            _currentSession = [[BAKSession alloc] initWithAuthToken:cachedAuthToken];
        } else {
            _currentSession = [BAKLoggedOutSession new];
        }
    });
    return _currentSession;
}

+ (void)closeSession {
    [_currentSession clearCache];
    _currentSession = [BAKLoggedOutSession new];
}

+ (instancetype)openSessionWithDictionary:(NSDictionary *)dictionary {
    NSAssert(_currentSession.isLoggedOut, @"You can't open a session if one is already open.");
    _currentSession = [[self alloc] initWithDictionary:dictionary];
    return _currentSession;
}

- (instancetype)initWithAuthToken:(NSString *)authToken {
    NSParameterAssert(authToken);
    self = [super init];
    if (!self) return nil;
    
    _authToken = authToken;
    
    [self persist];
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) return nil;
    
    NSAssert(dictionary[@"authToken"], @"You can't open a session without a valid auth token.");
    _authToken = dictionary[@"authToken"];
    _user = [[BAKUser alloc] initWithDictionary:dictionary[@"user"]];
    
    [self persist];
    
    return self;
}

- (void)persist {
    NSError *error;
    [self.keychain storeAuthToken:self.authToken error:&error];
    if (error) {
        NSLog(@"Keychain Error: %@", error);
    }
}

- (void)clearCache {
    NSError *error;
    [self.keychain deleteAuthToken:&error];
    if (error) {
        NSLog(@"Keychain Error: %@", error);
    }
}

- (BOOL)isLoggedIn {
    return YES;
}

- (BOOL)isLoggedOut {
    return !self.isLoggedIn;
}

- (BAKKeychain *)keychain {
    if (!_keychain) {
        self.keychain = [[BAKKeychain alloc] init];
    }
    return _keychain;
}

@end

@implementation BAKLoggedOutSession : BAKSession

- (BOOL)isLoggedIn {
    return NO;
}

- (NSString *)authToken {
    return @"";
}

@end
