//
//  BAKViewControllerRecycler.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKViewControllerRecycler.h"

@interface BAKViewControllerRecycler ()

@property (nonatomic) NSMutableSet *unusedViewControllers;
@property (nonatomic) NSMutableDictionary *viewControllersByIndexPath;

@end

@implementation BAKViewControllerRecycler

- (instancetype)initWithViewControllerClass:(Class)viewControllerClass parentViewController:(UIViewController *)parentViewController{
    self = [super init];
    if (!self) return nil;
    
    _viewControllerClass = viewControllerClass;
    _parentViewController = parentViewController;
    
    return self;
}

- (NSMutableSet *)unusedViewControllers {
    if (!_unusedViewControllers) {
        self.unusedViewControllers = [NSMutableSet set];
    }
    return _unusedViewControllers;
}

- (NSMutableDictionary *)viewControllersByIndexPath {
    if (!_viewControllersByIndexPath) {
        self.viewControllersByIndexPath = [NSMutableDictionary dictionary];
    }
    return _viewControllersByIndexPath;
}

- (id)recycledOrNewViewController {
    if (self.unusedViewControllers.count > 1) {
        id viewController = [self.unusedViewControllers anyObject];
        return viewController;
    }
    id viewController = [[self.viewControllerClass alloc] init];
    [self.parentViewController addChildViewController:viewController];
    [self.unusedViewControllers addObject:viewController];
    return viewController;
}

- (id)viewControllerAtIndexPath:(NSIndexPath *)indexPath {
    return self.viewControllersByIndexPath[indexPath];
}

- (void)recycleViewControllerAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.viewControllersByIndexPath[indexPath];
    [self.viewControllersByIndexPath removeObjectForKey:indexPath];
    [self.unusedViewControllers addObject:viewController];
}

- (void)hangOnToViewController:(id)viewController atIndexPath:(NSIndexPath *)indexPath {
    [self.unusedViewControllers removeObject:viewController];
    self.viewControllersByIndexPath[indexPath] = viewController;
}

@end
