//
//  BAKFirstRunLayout.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface BAKFirstRunLayout : NSObject

- (instancetype)initWithWorkingRect:(CGRect)workingRect emailButtonShowing:(BOOL)emailButtonShowing;

@property (nonatomic, readonly) CGRect scrollRect;
@property (nonatomic, readonly) CGRect createAccountRect;
@property (nonatomic, readonly) CGRect signInRect;
@property (nonatomic, readonly) CGRect postViaEmailRect;
@property (nonatomic, readonly) CGRect backchannelRect;
@property (nonatomic, readonly) CGRect descriptionRect;

@end
