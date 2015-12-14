//
//  AppDelegate.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/12/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "AppDelegate.h"
#import "BCRootViewController.h"
#import "Backchannel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[BCRootViewController alloc] init]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    NSString *APIKeyPListPath = [[NSBundle mainBundle] pathForResource:@"APIKey" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:APIKeyPListPath];
    
    [Backchannel setAPIKey:dictionary[@"APIKey"] rootViewController:navigationController];
    
    return YES;
}

@end
