//
//  Backchannel.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/12/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "Backchannel.h"
#import "BAKMessagesCoordinator.h"
#import "BAKRemoteConfiguration.h"
#import "BAKScreenshotDetectionCoordinator.h"

@interface Backchannel () <BAKMessageCoordinatorDelegate, BAKScreenshotDetectionDelegate>

@property (nonatomic) BAKRemoteConfiguration *configuration;
@property (nonatomic) NSMutableArray *coordinators;

@end

static NSString *_globalAPIKey;
static UIViewController *_rootViewController;

@implementation Backchannel

+ (instancetype)setAPIKey:(NSString *)APIKey {
    _globalAPIKey = APIKey;
    return self._backchannel;
}

+ (void)setAPIKey:(NSString *)APIKey rootViewController:(UIViewController *)rootViewController {
    _globalAPIKey = APIKey;
    _rootViewController = rootViewController;
    [self _backchannel];
}

+ (instancetype)backchannel {
    NSAssert(_globalAPIKey, @"You must set your API key before calling `+backchannel`.");
    return self._backchannel;
}

+ (instancetype)_backchannel {
    static Backchannel *backchannel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        backchannel = [Backchannel new];
    });
    return backchannel;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenshotDetected:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    self.configuration = [[BAKRemoteConfiguration alloc] initWithAPIKey:_globalAPIKey];
    
    return self;
}

- (BOOL)backchannelActive {
    return self.coordinators.count > 0;
}

- (UINavigationController *)presentNavigationControllerOnViewController:(UIViewController *)viewController {
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [viewController presentViewController:navigationController animated:YES completion:nil];
    return navigationController;
}

- (void)presentModallyOverViewController:(UIViewController *)viewController {
    UINavigationController *navigationController = [self presentNavigationControllerOnViewController:viewController];
    BAKMessagesCoordinator *coordinator = [[BAKMessagesCoordinator alloc] initWithNavigationController:navigationController configuration:self.configuration];
    coordinator.delegate = self;
    [self.coordinators addObject:coordinator];
    [coordinator start];
}

- (void)messageCoordinatorRequestsDismissal:(BAKMessagesCoordinator *)messagesCoordinator {
    [messagesCoordinator.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.coordinators removeObject:messagesCoordinator];
}

- (void)screenshotDetected:(NSNotification *)note {
    if (!_rootViewController) return;
    if (self.backchannelActive) return;
    BAKScreenshotDetectionCoordinator *screenshotDetection = [[BAKScreenshotDetectionCoordinator alloc] initWithViewController:_rootViewController configuration:self.configuration];
    screenshotDetection.delegate = self;
    [self.coordinators addObject:screenshotDetection];
    [screenshotDetection start];
}

- (void)screenshotDetectionCoordinatorCompleted:(BAKScreenshotDetectionCoordinator *)screenshotDetectionCoordinator {
    [screenshotDetectionCoordinator.viewController dismissViewControllerAnimated:YES completion:nil];
    [self.coordinators removeObject:screenshotDetectionCoordinator];
}

- (NSMutableArray *)coordinators {
    if (!_coordinators) {
        self.coordinators = [NSMutableArray array];
    }
    return _coordinators;
}

@end
